import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/request/refresh_token/api_refresh_token_request.dart';
import 'package:car_part/features/authentication/data/repository/model/Login.dart';
import 'package:car_part/features/authentication/data/repository/model/refresh_token.dart';

abstract class IAuthenticationRepository {
  Stream<Result<Login>> login(ApiLoginRequest request) {
    throw UnimplementedError();
  }

  Stream<Result<RefreshToken>> refreshToken(ApiRefreshTokenRequest request) {
    throw UnimplementedError();
  }
}
