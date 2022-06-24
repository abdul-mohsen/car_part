import 'package:json_annotation/json_annotation.dart';

import 'api_product_item.dart';

part 'api_product.g.dart';

@JsonSerializable()
class ApiProduct {
  final List<ApiProductItem>? data;

  const ApiProduct({this.data});

  @override
  String toString() => 'ApiProduct(data: $data)';

  factory ApiProduct.fromJson(Map<String, dynamic> json) {
    return _$ApiProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiProductToJson(this);
}
