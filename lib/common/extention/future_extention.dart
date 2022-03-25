import 'package:car_part/common/network/errors/ApiFailure/api_failure.dart';
import 'package:car_part/common/network/errors/generic_error.dart';
import 'package:car_part/common/network/errors/network_error.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:dio/dio.dart';

extension FutureHandler on Future<Response<Map<String, dynamic>?>> {
  Future<ResponseResult<T>> handleRemote<T>(
          T Function(Map<String, dynamic>) fromJson) =>
      then((value) {
        final response = value.data;
        if (response?['data'] != null) {
          return ResponseResult.success(fromJson(response!['data']));
        } else {
          return ResponseResult.failure<T>(GenericFailure());
        }
      }).onError((DioError error, stackTrace) {
        switch (error.type) {
          case DioErrorType.response:
            return ResponseResult.failure<T>(
                ApiFailure.fromJson(error.response?.data ?? {}));
          case DioErrorType.connectTimeout:
            return ResponseResult.failure<T>(
                NetworkError("url is opened timeout"));
          case DioErrorType.cancel:
            return ResponseResult.failure<T>(
                NetworkError("the request is cancelled"));
          case DioErrorType.receiveTimeout:
            return ResponseResult.failure<T>(NetworkError("receiving timeout"));
          case DioErrorType.sendTimeout:
            return ResponseResult.failure<T>(
                NetworkError("url is sent timeout"));
          default:
            return ResponseResult.failure<T>(
                NetworkError("unkonwn network error"));
        }
      }).onError((error, stackTrace) => ResponseResult.failure<T>(
          GenericError(error.toString(), error, stackTrace)));
}
