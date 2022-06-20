extension AnyExtention<T> on T? {
  T or(T item) => this ?? item;

  S? to<S>() => _cast(this);

  X? _cast<X>(x) => x is X ? x : null;

  T throwIfNull() {
    if (this == null) throw Exception();
    return this!;
  }
}

extension AnyNonNullExtention<T> on T {
  R let<R>(R Function(T) fun) => fun(this);
  T apply(void Function(T) fun) {
    fun(this);
    return this;
  }

  R runAndReturn<R>(R Function(T) fun) => fun(this);
}
