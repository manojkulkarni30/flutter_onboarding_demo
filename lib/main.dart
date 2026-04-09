import 'package:flutter/material.dart';
import 'package:flutter_onboarding_demo/home_page.dart';
import 'package:flutter_onboarding_demo/onboarding_page.dart';
import 'package:flutter_onboarding_demo/services/preferences_service.dart';
import 'package:flutter_onboarding_demo/utils/app_theme_notifier.dart';
import 'package:flutter_onboarding_demo/utils/app_theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesService.instance.init();
  bool? isOnboardingDone = await PreferencesService.instance.getBool(
    'onboarding_done',
  );
  String? theme = await PreferencesService.instance.getString(
    'themeMode',
  );
  final themeMode = theme == ThemeMode.light.name
      ? ThemeMode.light
      : ThemeMode.dark;
  runApp(
    AppThemeProvider(
      appThemeNotifier: AppThemeNotifier(themeMode),
      child: MyApp(isOnboardingDone: isOnboardingDone ?? false),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isOnboardingDone});

  final bool isOnboardingDone;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppThemeProvider.of(context).appThemeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.brown, brightness: .light),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.brown, brightness: .dark),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
          ),
          themeMode: value,
          home: isOnboardingDone ? const HomePage() : const OnboardingPage(),
        );
      },
    );
  }
}
