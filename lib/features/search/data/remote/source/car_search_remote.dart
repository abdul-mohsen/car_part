import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/search/data/remote/model/response/cars/car_search_response.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/future_extention.dart';

import 'car_search_api.dart';

abstract class CarSearchRemote {
  Future<ResponseResult<CarSearchResponse>> search(String query);
}

class CarSearchRemoteImpl implements CarSearchRemote {
  final api = Modular.get<DioClient>();

  @override
  Future<ResponseResult<CarSearchResponse>> search(String query) => api.dio
      .search(query)
      .handleRemote(CarSearchResponse.fromJson, isList: true);
}
