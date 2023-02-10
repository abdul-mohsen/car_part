import 'package:car_part/features/search/data/repository/model/car_search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_part/common/extention/any_extension.dart';

@immutable
class CarSearchItemResponse {
  final int? id;
  final int? modelId;
  final String? modelName;
  final int? yearOfConstructionTo;
  final int? yearOfConstructionFrom;
  final String? linkingTargetType;
  final int? manuId;

  const CarSearchItemResponse({
    this.id,
    this.modelId,
    this.modelName,
    this.yearOfConstructionTo,
    this.yearOfConstructionFrom,
    this.linkingTargetType,
    this.manuId,
  });

  @override
  String toString() {
    return 'CarPartSearchResponse(id: $id, modelId: $modelId, modelName: $modelName, yearOfConstructionTo: $yearOfConstructionTo, yearOfConstructionFrom: $yearOfConstructionFrom, linkingTargetType: $linkingTargetType, manuId: $manuId)';
  }

  factory CarSearchItemResponse.fromJson(Map<String, dynamic> json) {
    return CarSearchItemResponse(
      id: json['id'] as int?,
      modelId: json['modelId'] as int?,
      modelName: json['modelName'] as String?,
      yearOfConstructionTo: json['yearOfConstructionTo'] as int?,
      yearOfConstructionFrom: json['yearOfConstructionFrom'] as int?,
      linkingTargetType: json['linkingTargetType'] as String?,
      manuId: json['manuId'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'modelId': modelId,
        'modelName': modelName,
        'yearOfConstructionTo': yearOfConstructionTo,
        'yearOfConstructionFrom': yearOfConstructionFrom,
        'linkingTargetType': linkingTargetType,
        'manuId': manuId,
      };

  CarSearchResult toDomain() => CarSearchResult(
        id.or(-1),
        modelId.or(-1),
        modelName ?? "-",
        yearOfConstructionTo.or(0),
        yearOfConstructionFrom.or(0),
        linkingTargetType ?? "",
        manuId.or(-1),
      );
}
