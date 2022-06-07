import 'package:car_part/features/bill/data/domain/model/bill_product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:car_part/common/extention/any_extension.dart';

part 'api_bill_product_item.g.dart';

@JsonSerializable()
class ApiBillProductItem {
  @JsonKey(name: 'id')
  final int? productId;
  @JsonKey(name: 'part_name')
  final String? partName;
  @JsonKey(name: 'part_number')
  final String? partNumber;
  final String? price;
  final int? quantity;

  const ApiBillProductItem(
      {this.productId,
      this.partName,
      this.partNumber,
      this.price,
      this.quantity});

  @override
  String toString() {
    return 'ApiProductItem(productId: $productId, partName: $partName, partNumber: $partNumber, productPrice: $price, quantity $quantity)';
  }

  factory ApiBillProductItem.fromJson(Map<String, dynamic> json) =>
      _$ApiBillProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ApiBillProductItemToJson(this);

  BillProduct toDomain() => BillProduct(
      productId: productId.throwIfNull(),
      partName: partName.throwIfNull(),
      partNumber: partNumber.throwIfNull(),
      price: double.parse(price ?? "").throwIfNull(),
      quantity: quantity.throwIfNull());
}
