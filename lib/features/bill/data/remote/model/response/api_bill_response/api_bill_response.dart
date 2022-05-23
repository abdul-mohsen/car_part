import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_bill_item.dart';

part 'api_bill_response.g.dart';

@JsonSerializable()
class ApiBillResponse {
  final List<ApiBillItem>? data;

  const ApiBillResponse({this.data});

  @override
  String toString() => 'ApiBillResponse(data: $data)';

  factory ApiBillResponse.fromJson(Map<String, dynamic> json) {
    return _$ApiBillResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiBillResponseToJson(this);
}
