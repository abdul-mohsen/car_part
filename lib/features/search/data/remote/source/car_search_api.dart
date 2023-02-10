import 'package:car_part/common/network/end_point.dart';
import 'package:dio/dio.dart';

extension CarSearchApi on Dio {
  Future<Response<Map<String, dynamic>?>> search(String query) =>
      get(EndPoints.carsSearch, queryParameters: {'query': query});
}
