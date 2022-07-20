import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UnauthorizeDioIntercepter extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Modular.to.navigate('/login');
    return handler.next(err);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}
