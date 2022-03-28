import 'package:car_part/common/routing/route.dart';
import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/carPart/data/repository/car_part_repository_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ThirdPageViewModel extends ViewModel {
  final repo = Modular.get<ICarPartRepository>();
  void popUntilRootButtonTapped() {
    addToNavigation(
      const AppRouteSpec.popUntilRoot(),
    );
  }

  void popButtonTapped() {
    addToNavigation(
      const AppRouteSpec.pop(),
    );
  }

  void popUntilHomeButtonTapped() {
    addToNavigation(
      const AppRouteSpec(name: '/', action: AppRouteAction.popUntil),
    );
  }

  void popUntilSecondButtonTapped() {
    addToNavigation(
      const AppRouteSpec(name: '/second', action: AppRouteAction.popUntil),
    );
  }

  void temp() {
    repo.getCarPartAutoCompletelist("26300-02503");
  }
}
