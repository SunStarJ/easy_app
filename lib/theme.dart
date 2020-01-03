import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData myDarkTheme = ThemeData.dark().copyWith(
      accentColor: Colors.blue,
      appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        color: Colors.black,
        elevation: 1,
      ));
}