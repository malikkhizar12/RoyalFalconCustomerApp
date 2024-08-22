import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeChanger() : _themeMode = ThemeMode.system; // Default to system mode

  ThemeMode get themeMode => _themeMode;

  void updateSystemTheme(Brightness systemBrightness) {
    if (_themeMode == ThemeMode.system) {
      // If the current mode is system, update the theme based on the system brightness
      _themeMode = systemBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners(); // Notify listeners to rebuild widgets with the updated theme
    }
  }
}
