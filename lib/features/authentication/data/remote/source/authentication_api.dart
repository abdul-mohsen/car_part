import 'package:car_part/common/network/end_point.dart';
import 'package:dio/dio.dart';

extension CarPartApi on Dio {
  Future<Response<Map<String, dynamic>?>> login(
          String oemNumber, int pageNumber, int pageSize) =>
      post(EndPoints.login, data: {});
}
