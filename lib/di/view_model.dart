import 'package:car_part/features/authentication/ui/login/login_view_model.dart';
import 'package:car_part/features/bill/ui/view/bill_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> viewModelInjection() {
  return [
    Bind.factory((i) => LoginViewModel()),
    Bind.factory((i) => BillViewModel())
  ];
}
