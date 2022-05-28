extension AnyExtention<T> on T? {
  T or(T item) => this ?? item;

  S? to<S>() => _cast(this);

  X? _cast<X>(x) => x is X ? x : null;
}

extension AnyNonNullExtention<T> on T {
  void let(void Function(T) fun) => fun(this);
  T apply(void Function(T) fun) {
    fun(this);
    return this;
  }
}
