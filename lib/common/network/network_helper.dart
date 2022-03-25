import 'package:car_part/common/network/response_result.dart';

ResponseResult<T> handleApi<T>(T? data) {
  if (data != null) {
    return ResponseResult.success(data);
  } else {
    return ResponseResult.failure(GenericFailure());
  }
}

ResponseResult<S> handleRemote<T, S>(
        ResponseResult<T> api, S Function(T data) mapToDomain) =>
    api.either((error) => errorMapper(error), (data) => mapToDomain(data));
