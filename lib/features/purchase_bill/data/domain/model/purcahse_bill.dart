import 'package:equatable/equatable.dart';

class PurchaseBill extends Equatable {
  final int id;
  final String effectiveDate;
  final String paymentDueDate;
  final int state;
  final double subTotal;
  final double discount;
  final double vat;
  final int sequenceNumber;
  final int storeId;
  final int merchantId;
  final int? supplierId;
  final int? supplierSequenceNumber;

  const PurchaseBill(
      {required this.id,
      required this.effectiveDate,
      required this.paymentDueDate,
      required this.state,
      required this.subTotal,
      required this.discount,
      required this.vat,
      required this.sequenceNumber,
      required this.storeId,
      required this.merchantId,
      required this.supplierId,
      required this.supplierSequenceNumber});

  PurchaseBill copyWith(
      {final int? id,
      final String? effectiveDate,
      final String? paymentDueDate,
      final int? state,
      final double? subTotal,
      final double? discount,
      final double? vat,
      final int? sequenceNumber,
      final int? storeId,
      final int? merchantId,
      final int? supplierId,
      final int? supplierSequenceNumber}) {
    return PurchaseBill(
        id: id ?? this.id,
        effectiveDate: effectiveDate ?? this.effectiveDate,
        paymentDueDate: paymentDueDate ?? this.paymentDueDate,
        state: state ?? this.state,
        subTotal: subTotal ?? this.subTotal,
        discount: discount ?? this.discount,
        vat: vat ?? this.vat,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
        storeId: storeId ?? this.storeId,
        merchantId: merchantId ?? this.merchantId,
        supplierId: supplierId ?? this.supplierId,
        supplierSequenceNumber:
            supplierSequenceNumber ?? this.supplierSequenceNumber);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        effectiveDate,
        paymentDueDate,
        state,
        subTotal,
        discount,
        vat,
        sequenceNumber,
        storeId,
        merchantId,
        supplierId,
        supplierSequenceNumber
      ];
}
