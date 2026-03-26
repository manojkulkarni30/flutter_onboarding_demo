import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  late SharedPreferencesAsync _prefs;

  PreferencesService._internal();

  static PreferencesService instance = PreferencesService._internal();

  void init() {
    _prefs = SharedPreferencesAsync();
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return await _prefs.getBool(key);
  }
}
