import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AppPref();

  Future<String?> getUserAccessToken() => _get(accessToken);

  Future<void> setUserAccessToken({required String userAccessToken}) =>
      _set(accessToken, userAccessToken);

  Future<String?> getUserRefreshToken() => _get(refreshToken);

  Future<void> setUserRefreshToken({required String userRefreshToken}) =>
      _set(refreshToken, userRefreshToken);

  Future<String?> _get(String key) =>
      _prefs.then((prefs) => prefs.getString(key));

  Future<void> _set(String key, String value) =>
      _prefs.then((prefs) => prefs.setString(key, value));
}
