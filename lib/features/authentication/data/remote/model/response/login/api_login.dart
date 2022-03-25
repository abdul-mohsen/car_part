import 'package:json_annotation/json_annotation.dart';

part 'api_login.g.dart';

@JsonSerializable()
class ApiLogin {
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "refresh_token")
  final String? refreshToken;

  const ApiLogin({this.accessToken, this.refreshToken});

  @override
  String toString() {
    return 'ApiLogin(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  factory ApiLogin.fromJson(Map<String, dynamic> json) {
    return _$ApiLoginFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiLoginToJson(this);
}
