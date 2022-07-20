import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/extention/debug.dart';
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
  static const int cacheMeterDuration = 5 * 60;
  static const String cacheMeterkey = "REFRESH_TOKEN_CACHE_METER_KEY";
  bool isRefreshTokenJobActive = false;

  AuthenticatoinRepository() {
    _appPref.getStringRx(AppPref.accessToken).listen((event) {
      if (event == null) {
        refreshToken();
      }
    });
  }

  @override
  Future<Result<void>> login(ApiLoginRequest request) async {
    try {
      final result = (await _remote.login(request)).toResult();
      result.when((error) => null, (data) {
        final domain = _apiLoginMapper(result.data!);
        _appPref.setString(AppPref.accessToken, domain.accessToken);
        _appPref.setString(AppPref.refreshToken, domain.refreshToken);
        _appPref.setCacheMeter(cacheMeterkey);
      });
      return result;
    } catch (error) {
      return Result.Error(null);
    }
  }

  static Login _apiLoginMapper(ApiLogin response) =>
      Login(response.accessToken.or(""), response.refreshToken.or(""));

  @override
  void refreshToken() async {
    if (isRefreshTokenJobActive) return;
    isRefreshTokenJobActive = true;
    final refreshToken = await _appPref.getString(AppPref.refreshToken);
    final isValid =
        await _appPref.getCacheMeter(cacheMeterkey, cacheMeterDuration);
    if (refreshToken != null && !isValid) {
      try {
        final response = await _remote
            .refreshToken(ApiRefreshTokenRequest(refreshToken: refreshToken));
        response.toResult().when((error) {
          if (error.message == "invalid token") {
            _appPref.remove(AppPref.refreshToken);
          }
          return error;
        }, (data) {
          final domain = _apiRefreshTokenMapper(response.data!);
          _appPref.setCacheMeter(cacheMeterkey);
          _appPref.setString(AppPref.accessToken, domain.accessToken);
          return data;
        });
      } catch (error) {
        debug("refreshToken failed");
      }
    }
    isRefreshTokenJobActive = false;
  }

  static RefreshToken _apiRefreshTokenMapper(ApiRefreshToken response) =>
      RefreshToken(response.accessToken.or(""));
}
