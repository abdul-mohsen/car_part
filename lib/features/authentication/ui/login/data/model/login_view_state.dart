import 'package:car_part/common/extention/string_extension.dart';
import 'package:car_part/common/network/errors/app_error.dart';
import 'package:car_part/common/ui/Event.dart';

class LoginViewState {
  final Event<bool?> loading;
  final Event<UiError?> error;
  final bool enableLoginButton;
  final Event<bool?> navigate;
  final String? username;
  final String? password;

  LoginViewState(this.loading, this.error, this.enableLoginButton,
      this.navigate, this.username, this.password);
  factory LoginViewState.creat(
          bool? loading,
          UiError? error,
          bool? enableLoginButton,
          bool? navigate,
          String? username,
          String? password) =>
      LoginViewState(Event(loading), Event(error), enableLoginButton ?? false,
          Event(navigate), username, password);

  LoginViewState copyWith(
      {bool? loading,
      UiError? error,
      bool? enableLoginButton,
      bool? navigate,
      String? username,
      String? password}) {
    return LoginViewState.creat(
        loading ?? this.loading.getContentIfNotHandled(),
        error ?? this.error.getContentIfNotHandled(),
        enableLoginButton ?? this.enableLoginButton,
        navigate ?? this.navigate.getContentIfNotHandled(),
        username ?? this.username,
        password ?? this.password);
  }

  static LoginViewState initViewState() =>
      LoginViewState.creat(null, null, null, null, null, null);

  LoginViewState updateUsername(String? username) => copyWith(
      username: username,
      enableLoginButton: _updateLoginButton(username, password));

  LoginViewState updatePassword(String? password) => copyWith(
      password: password,
      enableLoginButton: _updateLoginButton(username, password));

  bool _updateLoginButton(String? username, String? password) =>
      !(username.isEmpytOrNull() || password.isEmpytOrNull());

  LoginViewState updateLoading() => copyWith(loading: true);

  LoginViewState updateError(UiError error) =>
      copyWith(loading: false, error: error);

  LoginViewState navigateToHomeScreen() =>
      copyWith(loading: false, navigate: true);
}
