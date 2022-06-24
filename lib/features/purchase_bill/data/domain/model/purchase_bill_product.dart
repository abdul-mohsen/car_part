import 'package:equatable/equatable.dart';

class PurchaseBillProduct extends Equatable {
  final int productId;
  final String partName;
  final String partNumber;
  final double price;
  final int quantity;

  const PurchaseBillProduct(
      {required this.productId,
      required this.partName,
      required this.partNumber,
      required this.price,
      required this.quantity});

  PurchaseBillProduct copyWith(
      {int? productId,
      String? partName,
      String? partNumber,
      double? price,
      int? quantity}) {
    return PurchaseBillProduct(
        productId: productId ?? this.productId,
        partName: partName ?? this.partName,
        partNumber: partNumber ?? this.partNumber,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [productId, partName, partNumber, price, quantity];
}
