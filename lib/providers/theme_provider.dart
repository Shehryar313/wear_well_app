import 'package:flutter/material.dart';

/// Manages the app's theme mode (dark / light) using Provider.
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true;

  /// Whether dark mode is currently active.
  bool get isDarkMode => _isDarkMode;

  /// Returns the current ThemeMode for MaterialApp.
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Switches between dark and light themes.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
