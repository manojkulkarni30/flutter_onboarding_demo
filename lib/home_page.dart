import 'package:flutter/material.dart';
import 'package:flutter_onboarding_demo/services/preferences_service.dart';
import 'package:flutter_onboarding_demo/utils/app_theme_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appThemeNotifier = AppThemeProvider.of(context).appThemeNotifier;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos App'),
        actions: [
          IconButton(
            onPressed: () async {
              appThemeNotifier.toggleTheme();
              await PreferencesService.instance.setString(
                'themeMode',
                appThemeNotifier.value.name,
              );
            },
            icon: appThemeNotifier.value == ThemeMode.light
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
          ),
        ],
      ),
    );
  }
}
