import 'package:car_part/common/cache/app_pref.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> cacheInjection() {
  return [Bind.singleton((i) => AppPref())];
}
