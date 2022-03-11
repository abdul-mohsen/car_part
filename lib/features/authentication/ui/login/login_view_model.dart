import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/authentication/ui/login/data/model/login_view_state.dart';
import 'package:car_part/features/carPart/data/repository/car_part_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends ViewModel {
  final _viewState =
      BehaviorSubject<LoginState>.seeded(LoginState.initViewState());
  Stream<LoginState> get viewState => _viewState;

  final client = Modular.get<CarPartRepository>();

  void updateUsername(String? username) =>
      _viewState.add(_viewState.value.updateUsername(username));

  void updatePassword(String? password) =>
      _viewState.add(_viewState.value.updatePassword(password));

  void onLoginPressed() {
    // _viewState.add(_viewState.value.updateLoading());
    // addToNavigation(const AppRouteSpec(
    //   name: '/second',
    //   arguments: {
    //     'count': -1,
    //   },
    // ));
  }

  @override
  void dispose() {
    super.dispose();
    _viewState.close();
  }
}
