import 'package:car_part/commen/network/result.dart';
import 'package:car_part/features/carPart/data/repository/model/car_part_auto_complete.dart';

abstract class ICarPartRepository {
  Stream<DataResult<List<CarPartAutoComplete>>> getCarPartAutoCompletelist(
      String oemNumber) {
    throw UnimplementedError();
  }
}
