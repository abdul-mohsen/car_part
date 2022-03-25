extension AnyExtention<T> on T? {
  T or(T item) {
    if (this == null) {
      return item;
    } else {
      return this!;
    }
  }

  S? to<S>() => _cast(this);

  X? _cast<X>(x) => x is X ? x : null;
}
