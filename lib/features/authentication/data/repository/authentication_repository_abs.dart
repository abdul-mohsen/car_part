import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/repository/model/Login.dart';

abstract class IAuthenticationRepository {
  Stream<Result<Login>> login(ApiLoginRequest request) {
    throw UnimplementedError();
  }

  void refreshToken() {
    throw UnimplementedError();
  }
}
