import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/features/product/data/remote/model/response/api_product/api_product.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_request/update_product_request.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_quentity_request/update_product_quentity_request.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/product/data/remote/source/product_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/future_extention.dart';
import 'package:car_part/features/product/data/remote/source/product_api.dart';

class ProductRemote implements IProductRemote {
  final api = Modular.get<DioClient>();

  @override
  Future<ResponseResult<ApiProduct>> getProducts(int page, int pageSize) =>
      api.dio
          .getProductList(page, pageSize)
          .handleRemote(ApiProduct.fromJson, isList: true);

  @override
  Future<ResponseResult<bool>> updateProduct(UpdateProductRequest request) =>
      api.dio.updateProduct(request).handleBoolRemote();

  @override
  Future<ResponseResult<bool>> updateProductQuantity(
          UpdateProductQuentityRequest request) =>
      api.dio.updateProductQuantity(request).handleBoolRemote();
}
