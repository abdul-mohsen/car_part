import 'package:flutter/cupertino.dart';

@immutable
class CarSearchResult {
  final int id;
  final int modelId;
  final String modelName;
  final int yearOfConstructionTo;
  final int yearOfConstructionFrom;
  final String linkingTargetType;
  final int manuId;

  const CarSearchResult(
    this.id,
    this.modelId,
    this.modelName,
    this.yearOfConstructionTo,
    this.yearOfConstructionFrom,
    this.linkingTargetType,
    this.manuId,
  );
}
