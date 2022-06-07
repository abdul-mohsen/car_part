import 'any_extension.dart';

extension NumListExtention<T extends num> on Iterable<T> {
  T sum(T base) => fold(base, (previous, current) => (previous + current).to());
}
