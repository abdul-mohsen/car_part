import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_product.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ApiProductItem {
  final int? id;
  final String? partName;
  final String? partNumber;
  final String? price;
  final int? quantity;

  const ApiProductItem({
    this.id,
    this.partName,
    this.partNumber,
    this.price,
    this.quantity,
  });

  @override
  String toString() {
    return 'Product(id: $id, partName: $partName, partNumber: $partNumber, price: $price, quantity: $quantity)';
  }

  factory ApiProductItem.fromJson(Map<String, dynamic> json) => ApiProductItem(
        id: json['id'] as int?,
        partName: json['part_name'] as String?,
        partNumber: json['part_number'] as String?,
        price: json['price'] as String?,
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'part_name': partName,
        'part_number': partNumber,
        'price': price,
        'quantity': quantity,
      };

  PurchaseBillProduct toDomain() => PurchaseBillProduct(
      productId: productId.throwIfNull(),
      partName: partName.throwIfNull(),
      partNumber: partNumber.throwIfNull(),
      price: double.parse(price ?? "").throwIfNull(),
      quantity: quantity.throwIfNull());
}
