import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode currentTheme;

  ThemeProvider({required this.currentTheme});

  void setTheme(ThemeMode currentTheme) {
    this.currentTheme = currentTheme;
    notifyListeners();
  }
}
