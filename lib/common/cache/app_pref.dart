import 'package:car_part/common/extention/debug.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class AppPref {
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String storeId = "storeId";
  static const String locale = "locale";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RxSharedPreferences? _rxPrefsInstance;
  Future<RxSharedPreferences> get _rxPrefs async {
    _rxPrefsInstance ??= (await _prefs).rx;
    return _rxPrefsInstance!;
  }

  Future<String?> getString(String key) =>
      _rxPrefs.then((prefs) => prefs.getString(key));

  Stream<String?> getStringRx(String key) async* {
    yield* (await _rxPrefs).getStringStream(key).distinct();
  }

  Future<int?> getInt(String key) =>
      _rxPrefs.then((prefs) => prefs.getInt(key));

  Future<void> setString(String key, String value) =>
      _rxPrefs.then((prefs) => prefs.setString(key, value));

  Future<void> setInt(String key, int value) =>
      _rxPrefs.then((prefs) => prefs.setInt(key, value));

  Future<void> remove(String key) =>
      _rxPrefs.then((prefs) => prefs.remove(key));

  Future<void> setCacheMeter(String key) => setInt(key, now());

  Future<bool> getCacheMeter(String key, int duration) async {
    int? value = await getInt(key);
    debug(value);
    debug(now());
    if (value != null) {
      return now() - value < duration * 1000;
    } else {
      return false;
    }
  }

  Stream<bool> getCacheMeterRx(String key, int duration) async* {
    final rxPrefx = await _rxPrefs;
    yield* rxPrefx.getIntStream(key).map((event) {
      if (event != null) {
        return now() - event < duration * 1000;
      } else {
        return false;
      }
    }).distinct();
  }

  int now() => DateTime.now().toUtc().millisecondsSinceEpoch;
}
