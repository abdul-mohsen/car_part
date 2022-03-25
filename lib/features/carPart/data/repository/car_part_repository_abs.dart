import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/carPart/data/repository/model/car_part_auto_complete.dart';

abstract class ICarPartRepository {
  Stream<ResponseResult<List<CarPartAutoComplete>>> getCarPartAutoCompletelist(
      String oemNumber) {
    throw UnimplementedError();
  }
}
