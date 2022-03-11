import 'package:car_part/common/network/result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login_request/api_login_request.dart';
import 'package:car_part/features/authentication/data/repository/model/Login.dart';

abstract class IAuthenticationRepository {
  Stream<DataResult<Login>> login(ApiLoginRequest request) {
    throw UnimplementedError();
  }
}
