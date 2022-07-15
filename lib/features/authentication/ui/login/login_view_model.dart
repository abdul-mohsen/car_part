import 'dart:async';
import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/routing/route.dart';
import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/repository/authentication_repository_abs.dart';
import 'package:car_part/features/authentication/ui/login/data/model/login_view_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends ViewModel {
  final _viewState =
      BehaviorSubject<LoginViewState>.seeded(LoginViewState.initViewState());
  Stream<LoginViewState> get viewState => _viewState;

  final _repo = Modular.get<IAuthenticationRepository>();
  final _appPref = Modular.get<AppPref>();

  @override
  void init() {
    super.init();
    _appPref.getStringRx(AppPref.refreshToken).listen((event) {
      if (event == null) {
        debug("to log in page");
        addToNavigation(
          const AppRouteSpec(name: '/', action: AppRouteAction.popUntil),
        );
      } else {
        debug("not log in page");
        addToNavigation(
          const AppRouteSpec(name: '/third', action: AppRouteAction.pushTo),
        );
      }
    });
  }

  void updateUsername(String? username) =>
      _viewState.add(_viewState.value.updateUsername(username));

  void updatePassword(String? password) =>
      _viewState.add(_viewState.value.updatePassword(password));

  void onLoginPressed() async {
    _viewState.add(_viewState.value.updateLoading());
    String username = _viewState.value.username ?? "";
    String password = _viewState.value.password ?? "";

    final result = await _repo
        .login(ApiLoginRequest(username: username, password: password));
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
    }, (data) => _viewState.add(_viewState.value.navigateToHomeScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    _viewState.close();
  }
}
