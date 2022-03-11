import 'package:json_annotation/json_annotation.dart';

part 'api_car_part_auto_complete.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiCarPartAutoComplete {
  @JsonKey(name: "data")
  final List<ApiCarPartAutoCompleteItem>? data;

  const ApiCarPartAutoComplete({this.data});

  factory ApiCarPartAutoComplete.fromJson(Map<String, dynamic> json) =>
      _$ApiCarPartAutoCompleteFromJson(json);

  Map<String, dynamic> toJson() => _$ApiCarPartAutoCompleteToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ApiCarPartAutoCompleteItem {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "oemNumber")
  final String? oemNumber;

  const ApiCarPartAutoCompleteItem({this.id, this.oemNumber});

  factory ApiCarPartAutoCompleteItem.fromJson(Map<String, dynamic> json) =>
      _$ApiCarPartAutoCompleteItemFromJson(json);

  Map<String, dynamic> toJson() => _$ApiCarPartAutoCompleteItemToJson(this);
}
