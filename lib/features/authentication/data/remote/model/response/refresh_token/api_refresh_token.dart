import 'package:json_annotation/json_annotation.dart';

part 'api_refresh_token.g.dart';

@JsonSerializable()
class ApiRefreshToken {
  @JsonKey(name: 'access_token')
  final String? accessToken;

  const ApiRefreshToken({this.accessToken});

  @override
  String toString() => 'ApiRefreshToken(accessToken: $accessToken)';

  factory ApiRefreshToken.fromJson(Map<String, dynamic> json) {
    return _$ApiRefreshTokenFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiRefreshTokenToJson(this);
}
