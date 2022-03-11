import 'package:car_part/example/screen_three/screen_three_view.dart';
import 'package:car_part/example/screen_three/screen_three_view_model.dart';
import 'package:car_part/example/screen_two/screen_two_view.dart';
import 'package:car_part/example/screen_two/screen_two_view_model.dart';
import 'package:car_part/features/authentication/ui/login/login_view.dart';
import 'package:car_part/features/authentication/ui/login/login_view_model.dart';
import 'package:car_part/home_page_view.dart';
import 'package:car_part/home_page_view_model.dart';
import 'package:flutter/material.dart';

export 'package:car_part/common/routing/route.dart';

class AppRouter {
  Route<dynamic>? route(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>? ?? {};

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginView(viewModel: LoginViewModel()),
        );
      case '/1':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(viewModel: HomePageViewModel()),
        );
      case '/second':
        final count = arguments['count'] as int?;

        if (count == null) {
          throw Exception('Route ${settings.name} requires a count');
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SecondPage(
            viewModel: SecondPageViewModel(count: count),
          ),
        );
      case '/third':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ThirdPage(viewModel: ThirdPageViewModel()),
        );
      default:
        throw Exception('Route ${settings.name} not implemented');
    }
  }
}
