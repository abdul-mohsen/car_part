class UiPurchaseBillView {
  final int id;
  final double subTotal;
  final double discount;
  final double vat;
  final String supplierId;
  final String supplierSequenceNumber;

  const UiPurchaseBillView(
      {required this.id,
      required this.subTotal,
      required this.discount,
      required this.vat,
      required this.supplierId,
      required this.supplierSequenceNumber});
}
