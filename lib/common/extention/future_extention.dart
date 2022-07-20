import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/network/errors/ApiFailure/api_failure.dart';
import 'package:car_part/common/network/errors/generic_error.dart';
import 'package:car_part/common/network/errors/network_error.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:dio/dio.dart';

extension FutureHandler on Future<Response<Map<String, dynamic>?>> {
  Future<ResponseResult<T>> handleRemote<T>(
          T Function(Map<String, dynamic>) fromJson,
          {bool isList = false}) =>
      then((value) {
        final response = value.data;
        if (response?['data'] != null) {
          if (isList) {
            return ResponseResult.success(fromJson(response!));
          } else {
            return ResponseResult.success(fromJson(response!['data']));
          }
        } else {
          return ResponseResult.failure<T>(NullData());
        }
      }).onError((DioError error, stackTrace) {
        switch (error.type) {
          case DioErrorType.response:
            if (error.response?.data is Map<String, dynamic>) {
              return ResponseResult.failure<T>(
                  ApiFailure.fromJson(error.response?.data ?? {}));
            } else {
              switch (error.response?.statusCode) {
                case 502:
                  return ResponseResult.failure(
                      NetworkError("server response timeout"));
                default:
                  return ResponseResult.failure<T>(GenericFailure());
              }
            }
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

  Future<ResponseResult<bool>> handleBoolRemote() =>
      then((value) => ResponseResult.success(true))
          .onError((DioError error, stackTrace) {
        switch (error.type) {
          case DioErrorType.response:
            if (error.response?.data is Map<String, dynamic>) {
              return ResponseResult.failure<bool>(
                  ApiFailure.fromJson(error.response?.data ?? {}));
            } else {
              return ResponseResult.failure<bool>(GenericFailure());
            }
          case DioErrorType.connectTimeout:
            return ResponseResult.failure<bool>(
                NetworkError("url is opened timeout"));
          case DioErrorType.cancel:
            return ResponseResult.failure<bool>(
                NetworkError("the request is cancelled"));
          case DioErrorType.receiveTimeout:
            return ResponseResult.failure<bool>(
                NetworkError("receiving timeout"));
          case DioErrorType.sendTimeout:
            return ResponseResult.failure<bool>(
                NetworkError("url is sent timeout"));
          default:
            return ResponseResult.failure<bool>(
                NetworkError("unkonwn network error"));
        }
      }).onError((error, stackTrace) => ResponseResult.failure<bool>(
              GenericError(error.toString(), error, stackTrace)));
}

extension FutureRepositoryHandler<T> on Future<ResponseResult<T>> {
  Future<Result<R>> handleRepository<R>(R Function(T) fromJson) =>
      then((value) => value.toResult().when(
              (error) => Result.Error<R>(error.message),
              (data) => Result.Success(fromJson(data))))
          .onError((error, stackTrace) => Result.Error(null));
}
