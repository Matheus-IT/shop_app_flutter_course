import 'package:flutter/material.dart';

class Theming {
  static getAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.purple,
      ),
      accentColor: Colors.deepOrange,
      primaryColor: Colors.purple,
      fontFamily: 'Lato',
    );
  }
}
