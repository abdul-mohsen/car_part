import 'package:car_part/common/network/end_point.dart';
import 'package:dio/dio.dart';

extension CarPartApi on Dio {
  Future<Response<Map<String, dynamic>?>> getCarPartAutoCompleteList(
          String oemNumber, int pageNumber, int pageSize) =>
      get(EndPoints.carPartAutoCompelete, queryParameters: {
        'oemNumber': oemNumber,
        'pageNumber': pageNumber,
        'pageSize': pageSize
      });
}
