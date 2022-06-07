extension NullableStringExtention on String? {
  bool isEmpytOrNull() => (this ?? "").isEmpty;
}

extension StringExtention on String {
  int? toInt() => int.tryParse(this);

  double? toDouble() {
    try {
      return double.tryParse(this);
    } catch (e) {
      return null;
    }
  }
}
