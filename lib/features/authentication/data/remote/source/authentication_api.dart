import 'package:car_part/common/network/end_point.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login_request/api_login_request.dart';
import 'package:dio/dio.dart';

extension CarPartApi on Dio {
  Future<Response<Map<String, dynamic>?>> login(ApiLoginRequest request) =>
      post(EndPoints.login, data: {request});
}
