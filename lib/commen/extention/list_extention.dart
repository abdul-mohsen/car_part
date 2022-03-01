extension ListExtention<T> on List<T> {
  List<T> addAllAndReturn(List<T> items) {
    addAll(items);
    return this;
  }
}
