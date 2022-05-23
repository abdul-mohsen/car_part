import 'package:json_annotation/json_annotation.dart';

import 'branch.dart';

part 'update_product_request.g.dart';

@JsonSerializable()
class UpdateProductRequest {
	@JsonKey(name: 'part_id') 
	final int? partId;
	final int? price;
	final List<Branch>? branches;

	const UpdateProductRequest({this.partId, this.price, this.branches});

	factory UpdateProductRequest.fromJson(Map<String, dynamic> json) {
		return _$UpdateProductRequestFromJson(json);
	}

	Map<String, dynamic> toJson() => _$UpdateProductRequestToJson(this);
}
