import 'package:car_part/example/screen_three/screen_three_view_model.dart';
import 'package:car_part/example/screen_two/screen_two_view_model.dart';
import 'package:car_part/features/authentication/ui/login/login_view_model.dart';
import 'package:car_part/features/bill/ui/details/bill_details_view_model.dart';
import 'package:car_part/features/bill/ui/view/bill_view_model.dart';
import 'package:car_part/features/purchase_bill/ui/details/purchase_bill_details_view_model.dart';
import 'package:car_part/features/purchase_bill/ui/view/purchase_bill_view_model.dart';
import 'package:car_part/home_page_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> viewModelInjection() {
  return [
    Bind.factory((i) => LoginViewModel()),
    Bind.factory((i) => BillViewModel()),
    Bind.factory((i) => BillDetailsViewModel()),
    Bind.factory((i) => ThirdPageViewModel()),
    Bind.factory((i) => SecondPageViewModel()),
    Bind.factory((i) => HomePageViewModel()),
    Bind.factory((i) => PurchaseBillViewModel()),
    Bind.factory((i) => PurchaseBillDetailsViewModel()),
  ];
}
