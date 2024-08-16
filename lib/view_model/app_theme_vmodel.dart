import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeChanger() : _themeMode = _loadThemeMode();

  static ThemeMode _loadThemeMode() {
    final box = Hive.box('settings');
    final storedTheme = box.get('themeMode', defaultValue: 'system');
    print(storedTheme);
    switch (storedTheme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveThemeMode(themeMode);
    notifyListeners();
  }

  void _saveThemeMode(ThemeMode themeMode) {
    final box = Hive.box('settings');
    switch (themeMode) {
      case ThemeMode.light:
        box.put('themeMode', 'light');
        break;
      case ThemeMode.dark:
        box.put('themeMode', 'dark');
        break;
      default:
        box.put('themeMode', 'system');
    }
  }
}
