import 'package:flutter/material.dart';
import 'package:flutter_onboarding_demo/utils/app_theme_notifier.dart';

class AppThemeProvider extends InheritedWidget {
  const AppThemeProvider({
    super.key,
    required super.child,
    required this.appThemeNotifier,
  });

  final AppThemeNotifier appThemeNotifier;

  static AppThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(AppThemeProvider oldWidget) {
    return oldWidget.appThemeNotifier.value != appThemeNotifier.value;
  }
}
