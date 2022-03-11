import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String accessToken;
  final String refreshToken;

  const Login(this.accessToken, this.refreshToken);

  Login copyWith({String? accessToken, String? refreshToken}) => Login(
        accessToken ?? this.accessToken,
        refreshToken ?? this.refreshToken,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
