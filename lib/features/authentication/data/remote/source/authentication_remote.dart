import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/request/refresh_token/api_refresh_token_request.dart';
import 'package:car_part/features/authentication/data/remote/model/response/login/api_login.dart';
import 'package:car_part/features/authentication/data/remote/model/response/refresh_token/api_refresh_token.dart';
import 'package:car_part/features/authentication/data/remote/source/authentcation_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/features/authentication/data/remote/source/authentication_api.dart';
import 'package:car_part/common/extention/future_extention.dart';

class AuthenticationRemote implements IAuthenticationRemote {
  final api = Modular.get<DioClient>();

  @override
  Future<ResponseResult<ApiLogin>> login(ApiLoginRequest request) =>
      api.dio.login(request).handleRemote(ApiLogin.fromJson);

  @override
  Future<ResponseResult<ApiRefreshToken>> refreshToken(
          ApiRefreshTokenRequest request) =>
      api.dio.refreshToken(request).handleRemote(ApiRefreshToken.fromJson);
}
