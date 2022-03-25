import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/request/refresh_token/api_refresh_token_request.dart';
import 'package:car_part/features/authentication/data/remote/model/response/login/api_login.dart';
import 'package:car_part/features/authentication/data/remote/model/response/refresh_token/api_refresh_token.dart';

abstract class IAuthenticationRemote {
  Future<ResponseResult<ApiLogin>> login(ApiLoginRequest request);
  Future<ResponseResult<ApiRefreshToken>> refreshToken(
      ApiRefreshTokenRequest request);
}
