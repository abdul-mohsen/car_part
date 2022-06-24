import 'package:car_part/features/purchase_bill/data/domain/model/purcahse_bill.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/extention/string_extension.dart';

@immutable
class ApiPurchaseBillItem {
  final int? id;
  final dynamic effectiveDate;
  final dynamic paymentDueDate;
  final int? state;
  final String? subTotal;
  final String? discount;
  final String? vat;
  final dynamic sequenceNumber;
  final int? storeId;
  final int? merchantId;
  final int? supplierId;
  final int? supplierSequenceNumber;
  final List<dynamic>? product;

  const ApiPurchaseBillItem({
    this.id,
    this.effectiveDate,
    this.paymentDueDate,
    this.state,
    this.subTotal,
    this.discount,
    this.vat,
    this.sequenceNumber,
    this.storeId,
    this.merchantId,
    this.supplierId,
    this.supplierSequenceNumber,
    this.product,
  });

  @override
  String toString() {
    return 'Datum(id: $id, effectiveDate: $effectiveDate, paymentDueDate: $paymentDueDate, state: $state, subTotal: $subTotal, discount: $discount, vat: $vat, sequenceNumber: $sequenceNumber, storeId: $storeId, merchantId: $merchantId, supplierId: $supplierId, supplierSequenceNumber: $supplierSequenceNumber, product: $product)';
  }

  factory ApiPurchaseBillItem.fromJson(Map<String, dynamic> json) =>
      ApiPurchaseBillItem(
        id: json['id'] as int?,
        effectiveDate: json['effective_date'] as dynamic,
        paymentDueDate: json['payment_due_date'] as dynamic,
        state: json['state'] as int?,
        subTotal: json['sub_total'] as String?,
        discount: json['discount'] as String?,
        vat: json['vat'] as String?,
        sequenceNumber: json['sequence_number'] as dynamic,
        storeId: json['store_id'] as int?,
        merchantId: json['merchant_id'] as int?,
        supplierId: json['supplier_id'] as int?,
        supplierSequenceNumber: json['supplier_sequence_number'] as int?,
        product: json['product'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'effective_date': effectiveDate,
        'payment_due_date': paymentDueDate,
        'state': state,
        'sub_total': subTotal,
        'discount': discount,
        'vat': vat,
        'sequence_number': sequenceNumber,
        'store_id': storeId,
        'merchant_id': merchantId,
        'supplier_id': supplierId,
        'supplier_sequence_number': supplierSequenceNumber,
        'product': product,
      };

  PurchaseBill toDomain() => PurchaseBill(
      id: id.or(-1),
      discount: discount?.toDouble() ?? 0.0,
      effectiveDate: effectiveDate.or("-"),
      merchantId: merchantId.or(0),
      paymentDueDate: paymentDueDate.or("-"),
      sequenceNumber: sequenceNumber.or(0),
      state: state.or(0),
      storeId: storeId.or(0),
      subTotal: subTotal?.toDouble() ?? 0.0,
      supplierId: supplierId,
      supplierSequenceNumber: sequenceNumber,
      vat: vat?.toDouble() ?? 0.0);
}
