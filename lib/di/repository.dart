import 'package:car_part/features/authentication/data/repository/authentication_repository.dart';
import 'package:car_part/features/bill/data/domain/repository/bill_repository.dart';
import 'package:car_part/features/carPart/data/repository/car_part_repository.dart';
import 'package:car_part/features/purchase_bill/data/domain/repository/purchase_bill_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> repositoryInjection() {
  return [
    Bind.singleton((i) => CarPartRepository()),
    Bind.singleton((i) => AuthenticatoinRepository()),
    Bind.singleton((i) => BillRepository()),
    Bind.singleton((i) => PurchaseBillRepository()),
  ];
}
