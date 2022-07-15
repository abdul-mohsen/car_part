import 'package:car_part/common/network/errors/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class Result<S> extends Equatable {
  // ignore: non_constant_identifier_names
  static Result<S> Error<S>(String? message) => _Error(UiError(message));
  // ignore: non_constant_identifier_names
  static Result<S> Success<S>(S data) => _Success(data);

  UiError? get error => fold<UiError?>((error) => error, (data) => null);

  S? get data => fold<S?>((error) => null, (data) => data);

  bool get isSuccess => this is _Success<S>;

  bool get isFailure => this is _Error<S>;

  S dataOrElse(S other) => isSuccess && data != null ? data! : other;

  S operator |(S other) => dataOrElse(other);

  O when<T, O>(O Function(UiError error) fnFailure, O Function(S data) fnData);

  Result<T> then<T>(Result<T> Function(S data) fnData);

  Result<T> map<T>(T Function(S data) fnData);

  T fold<T>(T Function(UiError error) fnFailure, T Function(S data) fnData);

  @override
  List<Object?> get props => [if (isSuccess) data else error];
}

class _Success<S> extends Result<S> {
  final S _value;

  _Success(this._value);

  @override
  O when<T, O>(O Function(UiError error) fnFailure, O Function(S data) fnData) {
    return fnData(_value);
  }

  @override
  Result<T> then<T>(Result<T> Function(S data) fnData) {
    return fnData(_value);
  }

  @override
  _Success<T> map<T>(T Function(S data) fnData) {
    return _Success<T>(fnData(_value));
  }

  @override
  T fold<T>(T Function(UiError error) fnFailure, T Function(S data) fnData) {
    return fnData(_value);
  }
}

class _Error<S> extends Result<S> {
  final UiError _value;

  _Error(this._value);

  @override
  O when<T, O>(O Function(UiError error) fnFailure, O Function(S data) fnData) {
    return fnFailure(_value);
  }

  @override
  _Error<T> map<T>(T Function(S data) fnData) {
    return _Error<T>(_value);
  }

  @override
  _Error<T> then<T>(Result<T> Function(S data) fnData) {
    return _Error<T>(_value);
  }

  @override
  T fold<T>(T Function(UiError error) fnFailure, T Function(S data) fnData) {
    return fnFailure(_value);
  }
}
