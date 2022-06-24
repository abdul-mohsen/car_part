import 'package:flutter/cupertino.dart';

@immutable
class PurchasePaymentRequest {
  final String? paymentDate;
  final int? paidAmount;

  const PurchasePaymentRequest({this.paymentDate, this.paidAmount});

  @override
  String toString() {
    return 'PurchasePaymentRequest(paymentDate: $paymentDate, paidAmount: $paidAmount)';
  }

  factory PurchasePaymentRequest.fromJson(Map<String, dynamic> json) {
    return PurchasePaymentRequest(
      paymentDate: json['payment_date'] as String?,
      paidAmount: json['paid_amount'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'payment_date': paymentDate,
        'paid_amount': paidAmount,
      };
}
