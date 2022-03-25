import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/carPart/data/remote/model/response/api_car_part_auto_complete.dart';

abstract class CarPartRemote {
  Future<ResponseResult<ApiCarPartAutoComplete>> getCarPartAutoCompleteList(
      String oemNumber);
}
