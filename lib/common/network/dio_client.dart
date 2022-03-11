import 'package:car_part/common/network/dio_intercepter.dart';
import 'package:car_part/common/network/end_point.dart';
import 'package:dio/dio.dart';

class DioClient {
  static const baseUrl = EndPoints.baseUrl;
  final _dio = Dio();

  DioClient() {
    _dio.interceptors.add(DioInterceptor());
    _dio.options.baseUrl = baseUrl;
  }

  Dio get dio => _dio;
}
