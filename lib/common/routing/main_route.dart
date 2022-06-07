import 'package:car_part/common/routing/gaurds.dart/login_gard.dart';
import 'package:car_part/example/screen_three/screen_three_view.dart';
import 'package:car_part/features/authentication/ui/login/login_view.dart';
import 'package:car_part/features/bill/ui/details/bill_details_view.dart';
import 'package:car_part/features/bill/ui/view/bill_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<ModularRoute> mainRoute() => [
      ChildRoute('/',
          child: (context, args) => const ThirdPage(), guards: [AuthGuard()]),
      ChildRoute('/bills',
          child: (context, args) => const BillView(), guards: [AuthGuard()]),
      ChildRoute('/bill_details',
          child: (context, args) => const BillDetailsView(),
          guards: [AuthGuard()]),
      ChildRoute('/login', child: (context, args) => const LoginView()),
      // WildcardRoute(child: (context, args) => NotFoundPage()),
    ];
