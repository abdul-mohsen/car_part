import 'package:car_part/common/network/result.dart';

DataResult<T> handleApi<T>(T? data) {
  if (data != null) {
    return DataResult.success(data);
  } else {
    return DataResult.failure(GenericFailure());
  }
}

DataResult<S> handleRemote<T, S>(
        DataResult<T> api, S Function(T data) mapToDomain) =>
    api.either((error) => errorMapper(error), (data) => mapToDomain(data));
