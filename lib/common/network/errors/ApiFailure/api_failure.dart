import 'package:car_part/common/network/response_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_failure.g.dart';

@JsonSerializable()
class ApiFailure extends Failure {
  final String? message;
  final int? code;

  ApiFailure({this.message, this.code});

  @override
  String toString() => 'ApiFailure(message: $message, code: $code)';

  factory ApiFailure.fromJson(Map<String, dynamic> json) {
    return _$ApiFailureFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiFailureToJson(this);
}
