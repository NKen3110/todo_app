# todo_app

todo_app project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation

Clone source code from GitHub (https://github.com/NKen3110/todo_app.git)

- Recommended run project with flutter version ^2.0 (tested on 2.5.3 and 2.8.0)

In terminal direct to todo_app (cd root/todo_app) and run below commands to config app

- flutter clean
- flutter packages get
- flutter packages upgrade (option)

## Config for Android

If flutter is below version 2.8, please:

- Open AndroidManifest.xml file in todo_app/android/app/src/main/ and change:
  <application
    android:name="${applicationName}" --> android:name="io.flutter.app.FlutterApplication"
    ...
  > ...</<application>
- Change build.gradle in todo_app/android/app:
  android {
    compileSdkVersion (flutter.compileSdkVersion --> 31)
    ...
    defaultConfig {
        ...
        minSdkVersion (flutter.minSdkVersion --> 21)
        targetSdkVersion (flutter.targetSdkVersion --> 31)
        ...
    }
    ...
  }

## Building and Running

Running on Web:

- Getting and saving data by using mock model

Running on device:

- Getting and saving data by using Sqlite local database

## UI Giude

Please read UI_Guide.pdf file in same project director

## Unit Testing

All files for testing:

- main_tabs_screen_test.dart
- create_new_task_test.dart
- task_name_validator_test.dart

Testing with VSCode:

- Open one in testing files file
- Select the Run menu
- Click the Start Debugging option

Run tests in a terminal

- flutter test test/files.dart
