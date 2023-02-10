import 'package:car_part/features/search/data/remote/model/response/cars/car_search_item_response.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CarSearchResponse {
  final List<CarSearchItemResponse>? data;

  const CarSearchResponse({this.data});

  factory CarSearchResponse.fromJson(Map<String, dynamic> json) =>
      CarSearchResponse(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) =>
                CarSearchItemResponse.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
