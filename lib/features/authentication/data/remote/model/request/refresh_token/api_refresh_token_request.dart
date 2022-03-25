import 'package:json_annotation/json_annotation.dart';

part 'api_refresh_token_request.g.dart';

@JsonSerializable()
class ApiRefreshTokenRequest {
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  const ApiRefreshTokenRequest({this.refreshToken});

  @override
  String toString() => 'ApiRefreshTokenRequest(refreshToken: $refreshToken)';

  factory ApiRefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    return _$ApiRefreshTokenRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiRefreshTokenRequestToJson(this);
}
