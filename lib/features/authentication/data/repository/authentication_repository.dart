import 'package:car_part/common/network/network_helper.dart';
import 'package:car_part/common/network/result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login_request/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/response/api_login/api_login.dart';
import 'package:car_part/features/authentication/data/remote/source/authentcation_remote_abs.dart';
import 'package:car_part/features/authentication/data/repository/authentication_repository_abs.dart';
import 'package:car_part/features/authentication/data/repository/model/Login.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/any_extension.dart';

class LoginRepository extends IAuthenticationRepository {
  final remote = Modular.get<IAuthenticationRemote>();
  @override
  Stream<DataResult<Login>> login(ApiLoginRequest request) => remote
      .login(request)
      .then((value) => handleRemote(value, apiLoginMapper))
      .onError((error, stackTrace) =>
          DataResult.failure(errorMapper(error ?? GenericFailure())))
      .asStream();

  static Login apiLoginMapper(ApiLogin response) =>
      Login(response.accessToken.or(""), response.refreshToken.or(""));
}
