import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/network/network_helper.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/request/refresh_token/api_refresh_token_request.dart';
import 'package:car_part/features/authentication/data/remote/model/response/login/api_login.dart';
import 'package:car_part/features/authentication/data/remote/model/response/refresh_token/api_refresh_token.dart';
import 'package:car_part/features/authentication/data/remote/source/authentcation_remote_abs.dart';
import 'package:car_part/features/authentication/data/repository/authentication_repository_abs.dart';
import 'package:car_part/features/authentication/data/repository/model/Login.dart';
import 'package:car_part/features/authentication/data/repository/model/refresh_token.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/any_extension.dart';

class AuthenticatoinRepository implements IAuthenticationRepository {
  final _remote = Modular.get<IAuthenticationRemote>();
  final _appPref = Modular.get<AppPref>();
  @override
  Stream<Result<Login>> login(ApiLoginRequest request) => _remote
      .login(request)
      .then((value) => _setUserToken(handleRemote(value, _apiLoginMapper)))
      .onError((error, stackTrace) => Result.Error(null))
      .asStream();

  static Login _apiLoginMapper(ApiLogin response) =>
      Login(response.accessToken.or(""), response.refreshToken.or(""));

  Result<Login> _setUserToken(ResponseResult<Login> domain) {
    domain.either((error) => error, (data) {
      _appPref.setUserAccessToken(userAccessToken: data.accessToken);
      _appPref.setUserRefreshToken(userRefreshToken: data.refreshToken);
      return data;
    });
    return domain.toResult();
  }

  @override
  Stream<Result<RefreshToken>> refreshToken(ApiRefreshTokenRequest request) =>
      _remote
          .refreshToken(request)
          .then((value) =>
              _setUserAccessToken(handleRemote(value, _apiRefreshTokenMapper)))
          .onError((error, stackTrace) => Result.Error(null))
          .asStream();

  static RefreshToken _apiRefreshTokenMapper(ApiRefreshToken response) =>
      RefreshToken(response.accessToken.or(""));

  Result<RefreshToken> _setUserAccessToken(
      ResponseResult<RefreshToken> domain) {
    domain.either((error) => error, (data) {
      _appPref.setUserAccessToken(userAccessToken: data.accessToken);
      return data;
    });
    return domain.toResult();
  }
}
