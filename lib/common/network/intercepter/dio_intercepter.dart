import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/features/authentication/data/repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DioInterceptor extends InterceptorsWrapper {
  final _appPref = Modular.get<AppPref>();
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool isValid = await _appPref.getCacheMeter(
        AuthenticatoinRepository.cacheMeterkey,
        AuthenticatoinRepository.cacheMeterDuration);

    if (!isValid) {
      _appPref.remove(AppPref.accessToken);
    }

    String? token = await _appPref
        .getString(AppPref.accessToken)
        .asStream()
        .firstWhere((element) => element != null);
    if (token != null) {
      options.headers["Authorization"] = "Bearer " + token;
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}
