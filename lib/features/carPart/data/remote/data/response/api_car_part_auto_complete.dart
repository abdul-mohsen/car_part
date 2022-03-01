import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_car_part_auto_complete.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiCarPartAutoComplete extends Equatable {
  @JsonKey(name: "data")
  final List<ApiCarPartAutoCompleteItem>? data;

  const ApiCarPartAutoComplete({this.data});

  factory ApiCarPartAutoComplete.fromJson(Map<String, dynamic> json) =>
      _$ApiCarPartAutoCompleteFromJson(json);

  Map<String, dynamic> toJson() => _$ApiCarPartAutoCompleteToJson(this);

  ApiCarPartAutoComplete copyWith({
    List<ApiCarPartAutoCompleteItem>? data,
  }) {
    return ApiCarPartAutoComplete(
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true)
class ApiCarPartAutoCompleteItem extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "oemNumber")
  final String? oemNumber;

  const ApiCarPartAutoCompleteItem({this.id, this.oemNumber});

  factory ApiCarPartAutoCompleteItem.fromJson(Map<String, dynamic> json) =>
      _$ApiCarPartAutoCompleteItemFromJson(json);

  Map<String, dynamic> toJson() => _$ApiCarPartAutoCompleteItemToJson(this);

  ApiCarPartAutoCompleteItem copyWith({
    int? id,
    String? oemNumber,
  }) {
    return ApiCarPartAutoCompleteItem(
      id: id ?? this.id,
      oemNumber: oemNumber ?? this.oemNumber,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, oemNumber];
}
