import 'package:car_part/common/network/intercepter/debug_dio_intercepter.dart';
import 'package:car_part/common/network/intercepter/dio_intercepter.dart';
import 'package:car_part/common/network/end_point.dart';
import 'package:car_part/common/network/intercepter/unauthorize_dio_intercepter.dart';
import 'package:dio/dio.dart';

class DioClient {
  static const baseUrl = EndPoints.baseUrl;
  final _dio = Dio();

  DioClient() {
    _dio.interceptors.add(DioInterceptor());
    _dio.interceptors.add(DebugDioIntercepter());
    _dio.options.baseUrl = baseUrl;
  }

  Dio get dio => _dio;
}

class UnauthorizeDioClient {
  final _dio = Dio();

  UnauthorizeDioClient() {
    _dio.interceptors.add(UnauthorizeDioIntercepter());
    _dio.interceptors.add(DebugDioIntercepter());
    _dio.options.baseUrl = DioClient.baseUrl;
  }

  Dio get dio => _dio;
}
