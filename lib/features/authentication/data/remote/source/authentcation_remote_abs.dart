import 'package:car_part/common/network/result.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login_request/api_login_request.dart';
import 'package:car_part/features/authentication/data/remote/model/response/api_login/api_login.dart';

abstract class IAuthenticationRemote {
  Future<DataResult<ApiLogin>> login(ApiLoginRequest request);
}
