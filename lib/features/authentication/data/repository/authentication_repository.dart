import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/network/network_helper.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/request/refresh_token/api_refresh_token_request.dart';
import 'package:car_part/features/authentication/data/remote/model/response/login/api_login.dart';
import 'package:car_part/features/authentication/data/remote/model/response/refresh_token/api_refresh_token.dart';
import 'package:car_part/features/authentication/data/remote/source/authentication_remote.dart';
import 'package:car_part/features/authentication/data/repository/authentication_repository_abs.dart';
import 'package:car_part/features/authentication/data/repository/model/Login.dart';
import 'package:car_part/features/authentication/data/repository/model/refresh_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/any_extension.dart';

class AuthenticatoinRepository implements IAuthenticationRepository {
  final _remote = Modular.get<AuthenticationRemote>();
  final _appPref = Modular.get<AppPref>();
  final int cacheMeterDuration = 5 * 60;
  final String cacheMeterkey = "REFRESH_TOKEN_CACHE_METER_KEY";
  bool isRefreshTokenJobActive = false;

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
      _appPref.setString(AppPref.accessToken, data.accessToken);
      _appPref.setString(AppPref.refreshToken, data.refreshToken);
      return data;
    });
    return domain.toResult();
  }

  @override
  void refreshToken() async {
    if (isRefreshTokenJobActive) return;
    isRefreshTokenJobActive = true;
    final refreshToken = await _appPref.getString(AppPref.refreshToken);
    final isValid =
        await _appPref.getCacheMeter(cacheMeterkey, cacheMeterDuration);
    if (refreshToken != null && isValid == true) {
      try {
        final response = await _remote
            .refreshToken(ApiRefreshTokenRequest(refreshToken: refreshToken));
        if (response.data != null) {
          final data = _apiRefreshTokenMapper(response.data!);
          _appPref.setString(AppPref.accessToken, data.accessToken);
          _appPref.setCacheMeter(cacheMeterkey);
        }
      } on DioError catch (error) {
        if (error.response?.statusCode == 400) {
          _appPref.remove(AppPref.refreshToken);
        }
      }
    }
    isRefreshTokenJobActive = false;
  }

  static RefreshToken _apiRefreshTokenMapper(ApiRefreshToken response) =>
      RefreshToken(response.accessToken.or(""));
}
