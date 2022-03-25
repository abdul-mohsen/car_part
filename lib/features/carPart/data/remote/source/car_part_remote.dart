import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/carPart/data/remote/model/response/api_car_part_auto_complete.dart';
import 'package:car_part/features/carPart/data/remote/source/car_part_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'car_part_api.dart';

class CarPartClient implements CarPartRemote {
  final api = Modular.get<DioClient>();

  @override
  Future<ResponseResult<ApiCarPartAutoComplete>> getCarPartAutoCompleteList(
          String oemNumber) =>
      api.dio
          .getCarPartAutoCompleteList(oemNumber, 0, 10)
          .then((value) => handlegetCarPartAutoCompleteListApi(value.data))
          .onError(
              (error, stackTrace) => ResponseResult.failure(GenericFailure()));
}

ResponseResult<ApiCarPartAutoComplete> handlegetCarPartAutoCompleteListApi(
    Map<String, dynamic>? data) {
  if (data != null) {
    final toObject = ApiCarPartAutoComplete.fromJson(data);
    if (toObject.data != null) {
      return ResponseResult.success(toObject);
    } else {
      return ResponseResult.failure(GenericFailure());
    }
  } else {
    return ResponseResult.failure(GenericFailure());
  }
}
