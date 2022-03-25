import 'package:equatable/equatable.dart';

class RefreshToken extends Equatable {
  final String accessToken;

  const RefreshToken(this.accessToken);

  RefreshToken copyWith({String? accessToken, String? refreshToken}) =>
      RefreshToken(
        accessToken ?? this.accessToken,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [accessToken];
}
