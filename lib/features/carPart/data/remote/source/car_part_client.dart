import 'package:car_part/commen/network/dio_client.dart';
import 'package:car_part/commen/network/result.dart';
import 'package:car_part/features/carPart/data/remote/data/response/api_car_part_auto_complete.dart';
import 'package:car_part/features/carPart/data/remote/source/car_part_remote.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'car_part_api.dart';

class CarPartClient implements CarPartRemote {
  final api = Modular.get<DioClient>();

  @override
  Future<DataResult<List<ApiCarPartAutoCompleteItem>>>
      getCarPartAutoCompleteList(String oemNumber) async {
    try {
      return await api.dio
          .getCarPartAutoCompleteList(oemNumber, 0, 10)
          .then((value) => handleApi1(value.data))
          .onError((error, stackTrace) => DataResult.failure(GenericFailure()));
    } catch (error) {
      return DataResult.failure(errorMapper(error));
    }
  }
}

DataResult<List<ApiCarPartAutoCompleteItem>> handleApi1(
    Map<String, dynamic>? data) {
  if (data != null) {
    return handleApi(ApiCarPartAutoComplete.fromJson(data));
  } else {
    return DataResult.failure(GenericFailure());
  }
}

DataResult<List<ApiCarPartAutoCompleteItem>> handleApi(
    ApiCarPartAutoComplete? value) {
  if (value != null && value.data != null) {
    return DataResult.success(value.data!);
  } else {
    return DataResult.failure(GenericFailure());
  }
}
