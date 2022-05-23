import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_quentity_request/update_product_quentity_request.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_request/update_product_request.dart';
import 'package:car_part/features/product/data/repository/model/product.dart';

abstract class IProductRepository {
  Stream<Result<List<Product>>> getProduct(int page, int pageSize) {
    throw UnimplementedError();
  }

  Future<Result<bool>> updateProduct(UpdateProductRequest request) {
    throw UnimplementedError();
  }

  Future<Result<bool>> updateProductQuantity(
      UpdateProductQuentityRequest request) {
    throw UnimplementedError();
  }
}
