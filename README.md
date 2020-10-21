# AODocs Flutter technical test

This project is about assessing Flutter (and Dart) developers abilities.

## Getting Started

### Prerequisites

The Flutter SDK should be installed, and [activated for Web development](https://flutter.dev/docs/get-started/web).

An IDE with support for Flutter is also recommended:
- Latest Android Studio (4.1+) and IntelliJ (2020.2+) with Flutter plugin
- Latest VSCode (1.50+) with Flutter plugin

Both IDEs support running Flutter in debug mode and setting breakpoint to perform step by step debugging.

### Running the project

**The local server MUST be run on port 57535 (required for Google authentication).**

In the root folder of the project, run `flutter run -d chrome --web-port=57535`

You can also run the project from your IDE:
- Android Studio and IntelliJ have a run configuration in the `.run` folder
- Latest VSCode has a run configuration in the `.vscode` folder

## Test Objectives

The following goals should be done in a strict time of one hour.
The implementation should be done in the `lib/main.dart` file (it is OK to split the main file to improve readability).

The steps to achieve in this test are:
1. List the first 25 [Files](https://developers.google.com/drive/api/v3/reference/files) from Drive for the current user and display the name of these files as a list
2. Add additional information for each item:
   - The name of the File should be the main information of the list item
   - The modification date of the File as a subtitle, displayed as a relative time like '3 hours ago' with a tooltip showing the absolute date 
   - The thumbnail of the File at the beginning of the list item (you will need to use the `fields` parameter in the Drive API request to retrieve the Modification date and the Thumbnail url)
3. Add a click action on the File thumbnails to display their preview in a new tab (the preview URL is available in the API response)
4. Add an action to star/unstar a File in Drive (the initial status should be correctly displayed)
5. Add a way to select one or more Files in the list, and star/unstar them in batch
6. (Optional) The list should be an infinite scroll, loading more files when scrolling down
7. (Bonus) Add an action to download the selected files as a ZIP archive

<a name="myfootnote1">1</a>: 
## Useful link

* Link to Drive API: https://developers.google.com/drive/api/v3/reference/

## Notes

You can use all the pub packages you need for this test.
