import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/carPart/data/repository/model/car_part_auto_complete.dart';

abstract class ICarPartRepository {
  Stream<Result<List<CarPartAutoComplete>>> getCarPartAutoCompletelist(
      String oemNumber) {
    throw UnimplementedError();
  }
}
