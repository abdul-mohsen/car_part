import 'package:car_part/common/extention/string_extension.dart';
import 'package:car_part/common/network/errors/app_error.dart';
import 'package:car_part/common/ui/Event.dart';

class LoginState {
  final Event<bool?> loading;
  final Event<UiError?> error;
  final bool enableLoginButton;
  final Event<bool?> navigate;
  final String? username;
  final String? password;

  LoginState(this.loading, this.error, this.enableLoginButton, this.navigate,
      this.username, this.password);
  factory LoginState.creat(
          bool? loading,
          UiError? error,
          bool? enableLoginButton,
          bool? navigate,
          String? username,
          String? password) =>
      LoginState(Event(loading), Event(error), enableLoginButton ?? false,
          Event(navigate), username, password);

  LoginState copyWith(
      {bool? loading,
      UiError? error,
      bool? enableLoginButton,
      bool? navigate,
      String? username,
      String? password}) {
    return LoginState.creat(
        loading ?? this.loading.getContentIfNotHandled(),
        error ?? this.error.getContentIfNotHandled(),
        enableLoginButton ?? this.enableLoginButton,
        navigate ?? this.navigate.getContentIfNotHandled(),
        username ?? this.username,
        password ?? this.password);
  }

  static LoginState initViewState() =>
      LoginState.creat(null, null, null, null, null, null);

  LoginState updateUsername(String? username) => copyWith(
      username: username,
      enableLoginButton: _updateLoginButton(username, password));

  LoginState updatePassword(String? password) => copyWith(
      password: password,
      enableLoginButton: _updateLoginButton(username, password));

  bool _updateLoginButton(String? username, String? password) =>
      !(username.isEmpytOrNull() || password.isEmpytOrNull());

  LoginState updateLoading() => copyWith(loading: true);

  LoginState updateError(UiError error) =>
      copyWith(loading: false, error: error);

  LoginState navigateToHomeScreen() => copyWith(loading: false, navigate: true);
}
