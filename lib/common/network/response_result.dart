// The code below was inspired by my swift implementation https://gist.github.com/CassiusPacheco/4378d30d69316e4a6ba28a0c3af72628
// and Avdosev's Dart Either https://github.com/avdosev/either_dart/blob/master/lib/src/either.dart

import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/network/errors/ApiFailure/api_failure.dart';
import 'package:car_part/common/network/errors/generic_error.dart';
import 'package:car_part/common/network/errors/network_error.dart';
import 'package:equatable/equatable.dart';
import 'package:car_part/common/extention/any_extension.dart';

abstract class Failure extends Equatable implements Exception {
  @override
  String toString() => '$runtimeType Exception';

  @override
  List<Object> get props => [];

  String? toAppError() {
    if (this is ApiFailure) {
      return to<ApiFailure>()?.message;
    } else if (this is NetworkError) {
      return to<NetworkError>()?.message;
    } else if (this is GenericError) {
      return to<GenericError>()?.message;
    }
    return null;
  }
}

// General failures
class GenericFailure extends Failure {}

class NullData extends Failure {}

Failure errorMapper(Object error) =>
    error is Failure ? error : GenericFailure();

/// This abstraction contains either a success data of generic type `S` or a
/// failure error of type `Failure` as its result.
///
/// `data` property must only be retrieved when `DataResult` was constructed by
/// using `DataResult.success(value)`. It can be validated by calling
/// `isSuccess` first. Alternatively, `dataOrElse` can be used instead since it
/// ensures a valid value is returned in case the result is a failure.
///
/// `error` must only be retrieved when `DataResult` was constructed by using
/// `DataResult.failure(error)`. It can be validated by calling `isFailure`
/// first.
abstract class ResponseResult<S> extends Equatable {
  static ResponseResult<S> failure<S>(Failure failure) =>
      _FailureResult(failure);
  static ResponseResult<S> success<S>(S data) => _SuccessResult(data);

  /// Get [error] value, returns null when the value is actually [data]
  Failure? get error => fold<Failure?>((error) => error, (data) => null);

  /// Get [data] value, returns null when the value is actually [error]
  S? get data => fold<S?>((error) => null, (data) => data);

  /// Returns `true` if the object is of the `SuccessResult` type, which means
  /// `data` will return a valid result.
  bool get isSuccess => this is _SuccessResult<S>;

  /// Returns `true` if the object is of the `FailureResult` type, which means
  /// `error` will return a valid result.
  bool get isFailure => this is _FailureResult<S>;

  /// Returns `data` if `isSuccess` returns `true`, otherwise it returns
  /// `other`.
  S dataOrElse(S other) => isSuccess && data != null ? data! : other;

  /// Sugar syntax that calls `dataOrElse` under the hood. Returns left value if
  /// `isSuccess` returns `true`, otherwise it returns the right value.
  S operator |(S other) => dataOrElse(other);

  /// Transforms values of [error] and [data] in new a `DataResult` type. Only
  /// the matching function to the object type will be executed. For example,
  /// for a `SuccessResult` object only the [fnData] function will be executed.
  R either<T, R>(
      R Function(Failure error) fnFailure, R Function(S data) fnData);

  /// Transforms value of [data] allowing a new `DataResult` to be returned.
  /// A `SuccessResult` might return a `FailureResult` and vice versa.
  ResponseResult<T> then<T>(ResponseResult<T> Function(S data) fnData);

  /// Transforms value of [data] always keeping the original identity of the
  /// `DataResult`, meaning that a `SuccessResult` returns a `SuccessResult` and
  /// a `FailureResult` always returns a `FailureResult`.
  ResponseResult<T> map<T>(T Function(S data) fnData);

  /// Folds [error] and [data] into the value of one type. Only the matching
  /// function to the object type will be executed. For example, for a
  /// `SuccessResult` object only the [fnData] function will be executed.
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData);

  @override
  List<Object?> get props => [if (isSuccess) data else error];

  Result<S> toResult() => either((error) => Result.Error(error.toAppError()),
      (data) => Result.Success(data));
}

/// Success implementation of `DataResult`. It contains `data`. It's abstracted
/// away by `DataResult`. It shouldn't be used directly in the app.
class _SuccessResult<S> extends ResponseResult<S> {
  final S _value;

  _SuccessResult(this._value);

  @override
  R either<T, R>(
      R Function(Failure error) fnFailure, R Function(S data) fnData) {
    return fnData(_value);
  }

  @override
  ResponseResult<T> then<T>(ResponseResult<T> Function(S data) fnData) {
    return fnData(_value);
  }

  @override
  _SuccessResult<T> map<T>(T Function(S data) fnData) {
    return _SuccessResult<T>(fnData(_value));
  }

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) {
    return fnData(_value);
  }
}

/// Failure implementation of `DataResult`. It contains `error`.  It's
/// abstracted away by `DataResult`. It shouldn't be used directly in the app.
class _FailureResult<S> extends ResponseResult<S> {
  final Failure _value;

  _FailureResult(this._value);

  @override
  R either<T, R>(
      R Function(Failure error) fnFailure, R Function(S data) fnData) {
    return fnFailure(_value);
  }

  @override
  _FailureResult<T> map<T>(T Function(S data) fnData) {
    return _FailureResult<T>(_value);
  }

  @override
  _FailureResult<T> then<T>(ResponseResult<T> Function(S data) fnData) {
    return _FailureResult<T>(_value);
  }

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) {
    return fnFailure(_value);
  }
}
