import 'package:car_part/commen/network/dio_client.dart';
import 'package:car_part/features/carPart/data/remote/source/car_part_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> remoteInjection() {
  return [
    Bind.singleton((i) => DioClient()),
    Bind.singleton((i) => CarPartClient())
  ];
}
