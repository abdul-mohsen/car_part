import 'dart:async';

import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/authentication/data/remote/model/request/login/api_login_request.dart';
import 'package:car_part/features/authentication/data/repository/authentication_repository.dart';
import 'package:car_part/features/authentication/data/repository/model/login.dart';
import 'package:car_part/features/authentication/ui/login/data/model/login_view_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends ViewModel {
  final _viewState =
      BehaviorSubject<LoginState>.seeded(LoginState.initViewState());
  Stream<LoginState> get viewState => _viewState;

  final _repo = Modular.get<AuthenticatoinRepository>();
  StreamSubscription<ResponseResult<Login>>? job;

  void updateUsername(String? username) =>
      _viewState.add(_viewState.value.updateUsername(username));

  void updatePassword(String? password) =>
      _viewState.add(_viewState.value.updatePassword(password));

  void onLoginPressed() {
    _viewState.add(_viewState.value.updateLoading());
    String username = _viewState.value.username ?? "";
    String password = _viewState.value.password ?? "";
    job?.cancel();
    job = _repo
        .login(ApiLoginRequest(username: username, password: password))
        .listen((event) {
      event.when((error) {
        _viewState.add(_viewState.value.updateError(error));
        return error;
      }, (data) {
        debug("ssda");
        _viewState.add(_viewState.value.navigateToHomeScreen());
        return data;
      });
    }) as StreamSubscription<ResponseResult<Login>>?;
  }

  @override
  void dispose() {
    super.dispose();
    _viewState.close();
  }
}
