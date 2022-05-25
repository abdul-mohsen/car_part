class UiBillView {
  final int id;
  final double subTotal;
  final double discount;
  final double vat;
  final double maintenanceCost;
  final String note;
  final String userName;
  final String userPhoneNumber;

  const UiBillView(
      {required this.id,
      required this.subTotal,
      required this.discount,
      required this.vat,
      required this.maintenanceCost,
      required this.note,
      required this.userName,
      required this.userPhoneNumber});
}
