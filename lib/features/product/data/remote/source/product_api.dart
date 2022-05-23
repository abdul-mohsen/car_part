import 'package:car_part/common/network/end_point.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_quentity_request/update_product_quentity_request.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_request/update_product_request.dart';
import 'package:dio/dio.dart';

extension ProductApi on Dio {
  Future<Response<Map<String, dynamic>?>> getProductList(
          int pageNumber, int pageSize) =>
      get(EndPoints.product,
          queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize});

  Future<Response<Map<String, dynamic>?>> updateProduct(
          UpdateProductRequest request) =>
      post(EndPoints.product, data: request.toJson());

  Future<Response<Map<String, dynamic>?>> updateProductQuantity(
          UpdateProductQuentityRequest request) =>
      post(EndPoints.productQuantity, data: request.toJson());
}
