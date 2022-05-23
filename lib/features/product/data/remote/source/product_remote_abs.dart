import 'dart:ffi';

import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_quentity_request/update_product_quentity_request.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_request/update_product_request.dart';
import 'package:car_part/features/product/data/remote/model/response/api_product/api_product.dart';

abstract class IProductRemote {
  Future<ResponseResult<ApiProduct>> getProducts(int page, int pageSize);
  Future<ResponseResult<bool>> updateProduct(UpdateProductRequest request);
  Future<ResponseResult<bool>> updateProductQuantity(
      UpdateProductQuentityRequest request);
}
