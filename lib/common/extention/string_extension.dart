extension NullableStringExtention on String? {
  bool isEmpytOrNull() => (this ?? "").isEmpty;
}

extension StringExtention on String {
  int? toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }

  double? toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }
}
