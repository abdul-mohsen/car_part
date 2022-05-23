import 'package:json_annotation/json_annotation.dart';

import 'branch.dart';

part 'update_product_quentity_request.g.dart';

@JsonSerializable()
class UpdateProductQuentityRequest {
	@JsonKey(name: 'product_id') 
	final int? productId;
	final double? price;
	final List<Branch>? branches;

	UpdateProductQuentityRequest({this.productId, this.price, this.branches});

	factory UpdateProductQuentityRequest.fromJson(Map<String, dynamic> json) {
		return _$UpdateProductQuentityRequestFromJson(json);
	}

	Map<String, dynamic> toJson() => _$UpdateProductQuentityRequestToJson(this);
}
