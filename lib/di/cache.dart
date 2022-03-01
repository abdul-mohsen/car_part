import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Bind> cacheInjection() {
  return [AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance())];
}
