import 'package:car_part/features/product/data/remote/model/response/api_product/api_product.dart';
import 'package:car_part/features/product/data/remote/source/product_remote_abs.dart';
import 'package:car_part/features/product/data/repository/model/product.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_request/update_product_request.dart';
import 'package:car_part/features/product/data/remote/model/request/update_product_quentity_request/update_product_quentity_request.dart';
import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/product/data/repository/product_repository_abs.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductRepository implements IProductRepository {
  final remote = Modular.get<IProductRemote>();

  @override
  Stream<Result<List<Product>>> getProduct(int page, int pageSize) => remote
      .getProducts(page, pageSize)
      .then((value) => value
          .toResult()
          .when((error) => error, (data) => apiProductMapper(data)))
      .onError((error, stackTrace) => Result.Error(null))
      .asStream();

  @override
  Future<Result<bool>> updateProduct(UpdateProductRequest request) => remote
      .updateProduct(request)
      .then((value) => value.toResult())
      .onError((error, stackTrace) => Result.Error(null));

  @override
  Future<Result<bool>> updateProductQuantity(
          UpdateProductQuentityRequest request) =>
      remote
          .updateProductQuantity(request)
          .then((value) => value.toResult())
          .onError((error, stackTrace) => Result.Error(null));

  List<Product> apiProductMapper(ApiProduct api) => api.data
      .or([])
      .map((item) => Product(
          productId: item.productId.or(-1),
          partName: item.partName.or("-"),
          productPrice: item.productPrice.or(0.0),
          partNumber: item.partNumber.or("-")))
      .toList();
}
