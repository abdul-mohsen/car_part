import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/features/authentication/data/remote/source/authentication_remote.dart';
import 'package:car_part/features/bill/data/remote/source/bill_remote.dart';
import 'package:car_part/features/carPart/data/remote/source/car_part_remote.dart';
import 'package:car_part/features/purchase_bill/data/remote/source/purchase_bill_remote.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> remoteInjection() {
  return [
    Bind.singleton((i) => DioClient()),
    Bind.singleton((i) => UnauthorizeDioClient()),
    Bind.singleton((i) => CarPartClient()),
    Bind.singleton((i) => AuthenticationRemote()),
    Bind.singleton((i) => BillRemote()),
    Bind.singleton((i) => PurchaseBillRemote())
  ];
}
