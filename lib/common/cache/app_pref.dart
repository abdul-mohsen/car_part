import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AppPref();

  Future<String?> getString(String key) =>
      _prefs.then((prefs) => prefs.getString(key));

  Future<int?> getInt(String key) => _prefs.then((prefs) => prefs.getInt(key));

  Future<void> setString(String key, String value) =>
      _prefs.then((prefs) => prefs.setString(key, value));

  Future<bool> setInt(String key, int value) =>
      _prefs.then((prefs) => prefs.setInt(key, value));

  Future<void> remove(String key) => _prefs.then((prefs) => prefs.remove(key));

  Future<void> setCacheMeter(String key) => setInt(key, now());

  Future<bool> getCacheMeter(String key, int duration) async {
    int? value = await getInt(key);
    if (value != null) {
      return now() - value > duration;
    } else {
      return false;
    }
  }

  int now() => DateTime.now().toUtc().second;
}
