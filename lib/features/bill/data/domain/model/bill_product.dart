import 'package:equatable/equatable.dart';

class BillProduct extends Equatable {
  final int productId;
  final String partName;
  final String partNumber;
  final double price;
  final int quantity;

  const BillProduct(
      {required this.productId,
      required this.partName,
      required this.partNumber,
      required this.price,
      required this.quantity});

  BillProduct copyWith(
      {int? productId,
      String? partName,
      String? partNumber,
      double? price,
      int? quantity}) {
    return BillProduct(
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
