extension NullableStringExtention on String? {
  bool isEmpytOrNull() => (this ?? "").isEmpty;
}
