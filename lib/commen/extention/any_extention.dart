extension AnyExtention<T> on T? {
  T or(T item) {
    if (this == null) {
      return item;
    } else {
      return this!;
    }
  }
}
