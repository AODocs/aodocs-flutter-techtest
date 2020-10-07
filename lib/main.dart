import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/drive/v3.dart';

const GB = 1024 * 1024 * 1024;

// Initializes Google authentication
GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '563231141203-ii1sq3308h8908bf14hbqacsssu43e64.apps.googleusercontent.com',
  scopes: [
    'email',
    'https://www.googleapis.com/auth/drive',
  ],
);

Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AODocs Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'AODocs Flutter technical test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Used to perform requests to the Drive API
  DriveApi _driveApi;
  
  /// The user returned by the Drive API using the about.get method 
  About _driveAbout;
  
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      //if not null, user is logged in
      if (account != null) {
        _initDriveApiClient().then(_getDriveUser);
      }
    });
    //signs in silently if already logged in
    _googleSignIn.signInSilently();
  }
  
  Future<DriveApi> _initDriveApiClient() async {
    //cache drive client to avoid reinitializing it
    if (_driveApi == null) {
      _driveApi = DriveApi(await _googleSignIn.authenticatedClient());
    } 
    return _driveApi;
  }

  Future<void> _getDriveUser(DriveApi driveApi) async {
    final aboutResponse = await driveApi.about.get($fields: "*");
    setState(() {
      _driveAbout = aboutResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _driveAbout == null ? _loginBody(context) : _buildBody(context),
      ),
    );
  }
  
  Column _loginBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text('You are not currently signed in.'),
            RaisedButton(
              child: const Text('SIGN IN'),
              onPressed: _handleSignIn,
            ),
          ],
        ),
      ],
    );
  }

  /// The exercise starts here!
  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 800, //should be OK on a full HD screen
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ListTile(
                leading: FlutterLogo(),
                title: Text("Hello ${_driveAbout.user.displayName}!"),
              ),
              ListTile(
                  title: Text(
                      "You are using ${toGB(_driveAbout.storageQuota.usage)} GB out of ${toGB(_driveAbout.storageQuota.limit)}"),
                  subtitle: Text(
                      "You can upload files up to ${toGB(_driveAbout.maxUploadSize)} GB")),
            ],
          ),
        ),
      ],
    );
  }

  String toGB(bytesAsString) => bytesAsString != null? (int.parse(bytesAsString) ~/ GB).toString() : "unlimited storage";
  
}
