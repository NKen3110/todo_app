import 'package:flutter/material.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/src/main_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainTabs(),
      onGenerateRoute: getRoute,
    );
  }
}
