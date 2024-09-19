import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Define ThemeData as class properties
  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      background: Colors.black,
      onBackground: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    // Add more dark theme customization here
  );

  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      background: Colors.white,
      onBackground: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    // Add more light theme customization here
  );

  ThemeData get themeData {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
