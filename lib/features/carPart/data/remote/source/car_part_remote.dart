import 'package:car_part/commen/network/result.dart';
import 'package:car_part/features/carPart/data/remote/data/response/api_car_part_auto_complete.dart';

abstract class CarPartRemote {
  Future<DataResult<List<ApiCarPartAutoCompleteItem>>>
      getCarPartAutoCompleteList(String oemNumber);
}
