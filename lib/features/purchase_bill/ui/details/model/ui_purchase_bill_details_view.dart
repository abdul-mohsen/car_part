import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_product.dart';

class UiPurchaseBillDetails {
  final int? id;
  final String effectiveDate;
  final String paymentDueDate;
  final int state;
  final double subTotal;
  final double discount;
  final double vat;
  final String sequenceNumber;
  final String supplierId;
  final String supplierSequenceNumber;
  final List<PurchaseBillProduct> products;

  UiPurchaseBillDetails(
      {required this.id,
      required this.effectiveDate,
      required this.paymentDueDate,
      required this.state,
      required this.subTotal,
      required this.discount,
      required this.vat,
      required this.sequenceNumber,
      required this.supplierId,
      required this.supplierSequenceNumber,
      required this.products});

  UiPurchaseBillDetails copy({
    int? id,
    String? effectiveDate,
    String? paymentDueDate,
    int? state,
    double? subTotal,
    double? discount,
    double? vat,
    String? sequenceNumber,
    String? supplierId,
    String? supplierSequenceNumber,
    List<PurchaseBillProduct>? products,
  }) =>
      UiPurchaseBillDetails(
          id: id ?? this.id,
          effectiveDate: effectiveDate ?? this.effectiveDate,
          paymentDueDate: paymentDueDate ?? this.paymentDueDate,
          state: state ?? this.state,
          subTotal: subTotal ?? this.subTotal,
          discount: discount ?? this.discount,
          vat: vat ?? this.vat,
          sequenceNumber: sequenceNumber ?? this.sequenceNumber,
          supplierId: supplierId ?? this.supplierId,
          supplierSequenceNumber:
              supplierSequenceNumber ?? this.supplierSequenceNumber,
          products: products ?? this.products);
}
