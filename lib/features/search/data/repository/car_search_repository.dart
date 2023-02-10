import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/search/data/remote/model/response/cars/car_search_response.dart';
import 'package:car_part/features/search/data/remote/source/car_search_remote.dart';
import 'package:car_part/features/search/data/repository/model/car_search_result.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/future_extention.dart';
import 'package:car_part/common/extention/any_extension.dart';

abstract class CarSearchRepository {
  Future<Result<List<CarSearchResult>>> search(String query);
}

class CarSearchRepositoryImpl implements CarSearchRepository {
  final remote = Modular.get<CarSearchRemote>();

  List<CarSearchResult> apiCarSearch(CarSearchResponse api) =>
      api.data.or([]).map((item) => item.toDomain()).toList();

  @override
  Future<Result<List<CarSearchResult>>> search(String query) =>
      remote.search(query).handleRepository(apiCarSearch);
}
