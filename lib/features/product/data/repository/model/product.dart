import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int productId;
  final String partName;
  final String partNumber;
  final double productPrice;

  const Product(
      {required this.productId,
      required this.partName,
      required this.partNumber,
      required this.productPrice});

  Product copyWith({
    int? productId,
    String? partName,
    String? partNumber,
    double? productPrice,
  }) {
    return Product(
      productId: productId ?? this.productId,
      partName: partName ?? this.partName,
      partNumber: partNumber ?? this.partNumber,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [productId, partName, partNumber, productPrice];
}
