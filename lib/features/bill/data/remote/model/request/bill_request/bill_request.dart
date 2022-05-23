import 'package:json_annotation/json_annotation.dart';

import 'product_request.dart';

part 'bill_request.g.dart';

@JsonSerializable()
class BillRequest {
  final int? state;
  final String? discount;
  @JsonKey(name: 'store_id')
  final int? storeId;
  @JsonKey(name: 'payment_due_date')
  final String? paymentDueDate;
  @JsonKey(name: 'payment_method')
  final int? paymentMethod;
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @JsonKey(name: 'paid_amount')
  final String? paidAmount;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'user_phone_number')
  final String? userPhoneNumber;
  final String? note;
  @JsonKey(name: 'maintenance_cost')
  final String? maintenanceCost;
  final List<ProductRequest>? products;

  const BillRequest({
    this.state,
    this.discount,
    this.storeId,
    this.paymentDueDate,
    this.paymentMethod,
    this.paymentDate,
    this.paidAmount,
    this.userName,
    this.userPhoneNumber,
    this.note,
    this.maintenanceCost,
    this.products,
  });

  @override
  String toString() {
    return 'BillRequest(state: $state, discount: $discount, storeId: $storeId, paymentDueDate: $paymentDueDate, paymentMethod: $paymentMethod, paymentDate: $paymentDate, paidAmount: $paidAmount, userName: $userName, userPhoneNumber: $userPhoneNumber, note: $note, maintenanceCost: $maintenanceCost, products: $products)';
  }

  factory BillRequest.fromJson(Map<String, dynamic> json) {
    return _$BillRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BillRequestToJson(this);
}
