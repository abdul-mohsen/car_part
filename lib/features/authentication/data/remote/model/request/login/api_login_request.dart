import 'package:json_annotation/json_annotation.dart';

part 'api_login_request.g.dart';

@JsonSerializable()
class ApiLoginRequest {
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "password")
  final String? password;

  const ApiLoginRequest({this.username, this.password});

  @override
  String toString() {
    return 'LoginRequest(username: $username, password: $password)';
  }

  factory ApiLoginRequest.fromJson(Map<String, dynamic> json) {
    return _$ApiLoginRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiLoginRequestToJson(this);
}
