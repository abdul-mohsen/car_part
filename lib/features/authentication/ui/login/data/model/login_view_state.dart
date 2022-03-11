import 'package:car_part/common/extention/string_extension.dart';
import 'package:car_part/common/ui/Event.dart';

class LoginState {
  final Event<bool?> loading;
  final Event<Error?> error;
  final bool enableLoginButton;
  final Event<bool?> navigate;
  final String? username;
  final String? passowrd;

  LoginState(this.loading, this.error, this.enableLoginButton, this.navigate,
      this.username, this.passowrd);
  factory LoginState.creat(bool? loading, Error? error, bool? enableLoginButton,
          bool? navigate, String? username, String? password) =>
      LoginState(Event(loading), Event(error), enableLoginButton ?? false,
          Event(navigate), username, password);

  LoginState copyWith(
      {bool? loading,
      Error? error,
      bool? enableLoginButton,
      bool? navigate,
      String? username,
      String? password}) {
    return LoginState.creat(
        loading, error, enableLoginButton, navigate, username, password);
  }

  static LoginState initViewState() =>
      LoginState.creat(null, null, null, null, null, null);

  LoginState updateUsername(String? username) => copyWith(
      username: username,
      enableLoginButton: _updateLoginButton(username, passowrd));

  LoginState updatePassword(String? password) => copyWith(
      username: username,
      enableLoginButton: _updateLoginButton(username, password));

  bool _updateLoginButton(String? username, String? passowrd) =>
      !(username.isEmpytOrNull() && passowrd.isEmpytOrNull());

  LoginState updateLoading() => copyWith(loading: true);

  LoginState updateError(Error error) => copyWith(loading: false, error: error);

  LoginState navigateToHomeScreen() => copyWith(loading: false, navigate: true);
}
