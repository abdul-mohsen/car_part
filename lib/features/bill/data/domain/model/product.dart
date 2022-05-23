import 'package:car_part/features/product/data/repository/model/product.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? productId;
  final double? price;
  final int? quantity;

  const Product(
      {required this.price, required this.productId, required this.quantity});

  Product copyWith({
    int? productId,
    double? price,
    int? quantity,
  }) {
    return Product(
      productId: productId ?? this.productId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [productId, price, quantity];
}
