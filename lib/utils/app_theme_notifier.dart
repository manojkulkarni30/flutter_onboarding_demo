import 'package:flutter/material.dart';

class AppThemeNotifier extends ValueNotifier<ThemeMode> {
  AppThemeNotifier(super.themeMode);

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
