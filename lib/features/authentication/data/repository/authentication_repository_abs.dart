import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';

abstract class IAuthenticationRepository {
  Future<Result<void>> login(ApiLoginRequest request) {
    throw UnimplementedError();
  }

  void refreshToken() {
    throw UnimplementedError();
  }
}
