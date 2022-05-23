import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch {
	@JsonKey(name: 'branch_id') 
	final int? branchId;
	final int? quantity;

	Branch({this.branchId, this.quantity});

	factory Branch.fromJson(Map<String, dynamic> json) {
		return _$BranchFromJson(json);
	}

	Map<String, dynamic> toJson() => _$BranchToJson(this);
}
