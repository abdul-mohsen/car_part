import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_response/api_purchase_bill_item.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ApiPurchaseBillResponse {
  final List<ApiPurchaseBillItem>? data;

  const ApiPurchaseBillResponse({this.data});

  @override
  String toString() => 'ApiPurchaseBillResponse(data: $data)';

  factory ApiPurchaseBillResponse.fromJson(Map<String, dynamic> json) {
    return ApiPurchaseBillResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ApiPurchaseBillItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
