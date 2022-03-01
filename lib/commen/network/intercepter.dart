import 'package:dio/dio.dart';

abstract class Intercepter {
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {}
  void onResponse(Response response, ResponseInterceptorHandler handler) {}
  void onError(DioError err, ErrorInterceptorHandler handler) {}
}
