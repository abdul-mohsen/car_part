import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/features/carPart/data/remote/model/response/api_car_part_auto_complete.dart';
import 'package:car_part/features/carPart/data/remote/source/car_part_remote_abs.dart';
import 'package:car_part/features/carPart/data/repository/car_part_repository_abs.dart';
import 'package:car_part/features/carPart/data/repository/model/car_part_auto_complete.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CarPartRepository implements ICarPartRepository {
  final remote = Modular.get<CarPartRemote>();
  @override
  Stream<Result<List<CarPartAutoComplete>>> getCarPartAutoCompletelist(
          String oemNumber) =>
      remote
          .getCarPartAutoCompleteList(oemNumber)
          .then((value) => value.toResult().when(
              (error) => error, (data) => apiCarPartAutoCompleteMapper(data)))
          .onError((error, stackTrace) => Result.Error(null))
          .asStream();

  List<CarPartAutoComplete> apiCarPartAutoCompleteMapper(
          ApiCarPartAutoComplete api) =>
      api.data
          .or([])
          .map((item) => CarPartAutoComplete(
              id: item.id.or(-1), oemNumber: item.oemNumber.or("")))
          .toList();
}
