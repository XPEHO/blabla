import 'package:blabla_example/blabla.dart';
import 'package:blabla_example/my_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  appLocales = [
    Locale('en', 'US'),
    Locale('fr', 'FR'),
    Locale('it', 'IT'),
  ];
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: appLocales,
      localizationsDelegates: blablaDelegates,
      home: MyHomePage(title: 'Blabla example'),
    );
  }
}
