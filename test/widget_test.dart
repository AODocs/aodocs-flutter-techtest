// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:aodocs_flutter_tech_test/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Checks login', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the SIGN IN button is present
    expect(find.text('SIGN IN'), findsOneWidget);
  });
}
