import 'package:car_part/common/network/end_point.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/request/refresh_token/api_refresh_token_request.dart';
import 'package:dio/dio.dart';

extension CarPartApi on Dio {
  Future<Response<Map<String, dynamic>?>> login(ApiLoginRequest request) =>
      post(EndPoints.login, data: request.toJson());

  Future<Response<Map<String, dynamic>?>> refreshToken(
          ApiRefreshTokenRequest request) =>
      post(EndPoints.refreshToken, data: request.toJson());
}
