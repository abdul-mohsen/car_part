import 'package:flutter/cupertino.dart';

import 'purchase_bill_product_item.dart';

@immutable
class PurchaseBillRequest {
  final int? state;
  final String? discount;
  final int? storeId;
  final String? paymentDueDate;
  final String? paymentMethod;
  final String? paymentDate;
  final String? paidAmount;
  final String? supplierSequenceNumber;
  final String? supplierId;
  final List<PurchaseBillProductItem>? products;

  const PurchaseBillRequest({
    this.state,
    this.discount,
    this.storeId,
    this.paymentDueDate,
    this.paymentMethod,
    this.paymentDate,
    this.paidAmount,
    this.supplierSequenceNumber,
    this.supplierId,
    this.products,
  });

  @override
  String toString() {
    return 'PurchaseBillRequest(state: $state, discount: $discount, storeId: $storeId, paymentDueDate: $paymentDueDate, paymentMethod: $paymentMethod, paymentDate: $paymentDate, paidAmount: $paidAmount, supplierSequenceNumber: $supplierSequenceNumber, supplierId: $supplierId, products: $products)';
  }

  factory PurchaseBillRequest.fromJson(Map<String, dynamic> json) {
    return PurchaseBillRequest(
      state: json['state'] as int?,
      discount: json['discount'] as String?,
      storeId: json['store_id'] as int?,
      paymentDueDate: json['payment_due_date'] as dynamic,
      paymentMethod: json['payment_method'] as dynamic,
      paymentDate: json['payment_date'] as dynamic,
      paidAmount: json['paid_amount'] as dynamic,
      supplierSequenceNumber: json['supplier_sequence_number'] as String?,
      supplierId: json['supplier_id'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) =>
              PurchaseBillProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'state': state,
        'discount': discount,
        'store_id': storeId,
        'payment_due_date': paymentDueDate,
        'payment_method': paymentMethod,
        'payment_date': paymentDate,
        'paid_amount': paidAmount,
        'supplier_sequence_number': supplierSequenceNumber,
        'supplier_id': supplierId,
        'products': products?.map((e) => e.toJson()).toList(),
      };
}
