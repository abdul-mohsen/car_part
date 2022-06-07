import 'package:car_part/common/cache/app_pref.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');
  @override
  Future<bool> canActivate(String path, ModularRoute route) =>
      Modular.get<AppPref>()
          .getString(AppPref.refreshToken)
          .then((value) => value != null)
          .onError((error, stackTrace) => false);
}
