import 'package:car_part/common/network/result.dart';
import 'package:car_part/features/carPart/data/remote/model/response/api_car_part_auto_complete.dart';

abstract class CarPartRemote {
  Future<DataResult<ApiCarPartAutoComplete>> getCarPartAutoCompleteList(
      String oemNumber);
}
