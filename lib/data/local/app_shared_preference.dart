import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  late final SharedPreferences _prefs;

  Future<bool> getBool({required String key}) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key) ?? false;
  }

  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(key, value);
  }

  Future<void> remove(String key) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }
}
