import 'package:car_part/commen/routing/route.dart';
import 'package:car_part/commen/ui/view_model.dart';
import 'package:rxdart/rxdart.dart';

class ThirdPageViewModel extends ViewModel {
  final _routesSubject = PublishSubject<AppRouteSpec>();
  Stream<AppRouteSpec> get routes => _routesSubject;

  void popUntilRootButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec.popUntilRoot(),
    );
  }

  void popButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec.pop(),
    );
  }

  void popUntilHomeButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec(name: '/', action: AppRouteAction.popUntil),
    );
  }

  void popUntilSecondButtonTapped() {
    _routesSubject.add(
      const AppRouteSpec(name: '/second', action: AppRouteAction.popUntil),
    );
  }

  @override
  void dispose() {
    _routesSubject.close();
  }
}
