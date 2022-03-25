import 'dart:io';

import 'package:car_part/common/network/response_result.dart';

class NetworkError extends Failure implements IOException {
  final String message;
  NetworkError(this.message);
}
