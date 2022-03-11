class Event<T> {
  final T? _content;
  bool _hasBeenHandled = false;

  Event(this._content);

  T? getContentIfNotHandled() {
    if (_hasBeenHandled) return null;
    _hasBeenHandled = true;
    return _content;
  }
}
