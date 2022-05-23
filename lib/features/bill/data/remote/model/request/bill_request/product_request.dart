import 'package:json_annotation/json_annotation.dart';

part 'product_request.g.dart';

@JsonSerializable()
class ProductRequest {
  @JsonKey(name: 'product_id')
  final int? productId;
  final double? price;
  final int? quantity;

  const ProductRequest({this.productId, this.price, this.quantity});

  @override
  String toString() {
    return 'ProductRequest(productId: $productId, price: $price, quantity: $quantity)';
  }

  factory ProductRequest.fromJson(Map<String, dynamic> json) {
    return _$ProductRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductRequestToJson(this);
}
