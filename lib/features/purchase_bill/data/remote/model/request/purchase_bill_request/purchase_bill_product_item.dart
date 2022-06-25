import 'package:flutter/cupertino.dart';

@immutable
class PurchaseBillProductItem {
  final int? productId;
  final double? price;
  final int? quantity;

  const PurchaseBillProductItem({this.productId, this.price, this.quantity});

  @override
  String toString() {
    return 'Product(productId: $productId, price: $price, quantity: $quantity)';
  }

  factory PurchaseBillProductItem.fromJson(Map<String, dynamic> json) =>
      PurchaseBillProductItem(
        productId: json['product_id'] as int?,
        price: (json['price'] as num?)?.toDouble(),
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'price': price,
        'quantity': quantity,
      };
}
