import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/features/authentication/data/remote/source/authentication_remote.dart';
import 'package:car_part/features/carPart/data/remote/source/car_part_remote.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> remoteInjection() {
  return [
    Bind.singleton((i) => DioClient()),
    Bind.singleton((i) => CarPartClient()),
    Bind.singleton((i) => AuthenticationRemote())
  ];
}
