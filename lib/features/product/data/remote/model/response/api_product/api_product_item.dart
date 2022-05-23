import 'package:json_annotation/json_annotation.dart';

part 'api_product_item.g.dart';

@JsonSerializable()
class ApiProductItem {
  final int? productId;
  final String? partName;
  final String? partNumber;
  final double? productPrice;

  const ApiProductItem({
    this.productId,
    this.partName,
    this.partNumber,
    this.productPrice,
  });

  @override
  String toString() {
    return 'ApiProductItem(productId: $productId, partName: $partName, partNumber: $partNumber, productPrice: $productPrice)';
  }

  factory ApiProductItem.fromJson(Map<String, dynamic> json) =>
      _$ApiProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ApiProductItemToJson(this);
}
