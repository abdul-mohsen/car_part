import 'package:json_annotation/json_annotation.dart';

part 'payment_request.g.dart';

@JsonSerializable()
class PaymentRequest {
  final int? id;
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @JsonKey(name: 'paid_amount')
  final String? paidAmount;

  const PaymentRequest({this.id, this.paymentDate, this.paidAmount});

  @override
  String toString() {
    return 'PaymentRequest(id: $id, paymentDate: $paymentDate, paidAmount: $paidAmount)';
  }

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return _$PaymentRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
}
