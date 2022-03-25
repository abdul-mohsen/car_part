import 'package:car_part/common/network/response_result.dart';

class GenericError extends Failure {
  final String message;
  final Object? error;
  final StackTrace stackTrace;
  GenericError(this.message, this.error, this.stackTrace);
}
