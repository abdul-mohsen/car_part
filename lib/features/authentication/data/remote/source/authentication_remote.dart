import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/common/network/network_helper.dart';
import 'package:car_part/common/network/result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login_request/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/response/api_login/api_login.dart';
import 'package:car_part/features/authentication/data/remote/source/authentcation_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/features/authentication/data/remote/source/authentication_api.dart';

class AuthenticationRemote implements IAuthenticationRemote {
  final api = Modular.get<DioClient>();

  @override
  Future<DataResult<ApiLogin>> login(ApiLoginRequest request) => api.dio
      .login(request)
      .then((value) => handleApi(ApiLogin.fromJson(value.data ?? {})))
      .onError((error, stackTrace) =>
          DataResult.failure(errorMapper(error ?? GenericFailure())));
}
