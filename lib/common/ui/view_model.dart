import 'package:car_part/common/routing/route.dart';
import 'package:rxdart/rxdart.dart';

abstract class ViewModel {
  ViewModel();

  final _routesSubject = PublishSubject<AppRouteSpec>();
  Stream<AppRouteSpec> get routes => _routesSubject;

  /// This method is executed exactly once for each State object Flutter's
  /// framework creates.
  void init() {}

  ///  This method is executed whenever the Widget's Stateful State gets
  /// disposed. It might happen a few times, always matching the amount of times
  /// `init` is called.
  void dispose() {
    _routesSubject.close();
  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  void routingDidPopNext() {}

  /// Called when the current route has been pushed.
  void routingDidPush() {}

  /// Called when the current route has been popped off.
  void routingDidPop() {}

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  void routingDidPushNext() {}

  void addToNavigation(AppRouteSpec event) {
    _routesSubject.add(event);
  }
}
