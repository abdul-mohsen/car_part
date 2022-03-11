import 'package:car_part/common/routing/route.dart';
import 'package:car_part/common/ui/view_model.dart';

class ThirdPageViewModel extends ViewModel {
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
}
