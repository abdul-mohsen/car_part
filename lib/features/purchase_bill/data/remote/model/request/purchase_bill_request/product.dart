import 'package:flutter/cupertino.dart';

@immutable
class Product {
  final int? productId;
  final double? price;
  final int? quantity;

  const Product({this.productId, this.price, this.quantity});

  @override
  String toString() {
    return 'Product(productId: $productId, price: $price, quantity: $quantity)';
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
