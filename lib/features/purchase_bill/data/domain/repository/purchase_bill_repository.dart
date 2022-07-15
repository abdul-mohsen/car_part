import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_details.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purcahse_bill.dart';
import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/purchase_bill/data/domain/repository/purchase_bill_repository_abs.dart';
import 'package:car_part/features/purchase_bill/data/local/model/cached_purchase_bill.dart';
import 'package:car_part/features/purchase_bill/data/local/source/cache_purchase_bill_abs.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_payment_request.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_bill_request/purchase_bill_request.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_details/api_purchase_bill_details.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_response/api_purchase_bill_item.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_response/api_purchase_bill_response.dart';
import 'package:car_part/features/purchase_bill/data/remote/source/purchase_bill_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/future_extention.dart';
import 'package:car_part/common/extention/any_extension.dart';

class PurchaseBillRepository implements IPurchaseBillRepository {
  final remote = Modular.get<IPurchaseBillRemote>();
  final cache = Modular.get<ICachePurchaseBill>();
  int page = 0;
  final pageSize = 20;

  @override
  Future<Result<bool>> addBill(PurchaseBillRequest request) =>
      remote.addBill(request).handleRepository((response) {
        final toDomain = apiBillMapper(response);
        cache.insertBill(CachcedPurchaseBill.fromDomain(toDomain));
        return true;
      });

  @override
  Future<Result<bool>> addPayment(int billId, PurchasePaymentRequest request) =>
      remote.addPayment(billId, request).handleRepository((p0) => true);

  @override
  Future<Result<bool>> deleteBill(int billId) =>
      remote.deleteBill(billId).handleRepository((p0) {
        cache.deleteBill(billId);
        return true;
      });

  @override
  Future<Result<PurchaseBillDetails>> getBillDetails(int billId) =>
      remote.getBillDetails(billId).handleRepository(apiBillDetailsMapper);

  @override
  Stream<List<PurchaseBill>> getBills() => cache.getBills().map(
      (items) => items.map((e) => CachcedPurchaseBill.mapToDomain(e)).toList());

  @override
  Future<Result<bool>> updateBills(int billId, PurchaseBillRequest request) {
    cache.deleteBill(billId);
    return remote.updateBill(billId, request).handleRepository((response) {
      final toDomain = apiBillMapper(response);
      cache.insertBill(CachcedPurchaseBill.fromDomain(toDomain));
      return true;
    });
  }

  List<PurchaseBill> apiBillsMapper(ApiPurchaseBillResponse api) =>
      api.data.or([]).map((item) => apiBillMapper(item)).toList();

  PurchaseBill apiBillMapper(ApiPurchaseBillItem api) => api.toDomain();

  PurchaseBillDetails apiBillDetailsMapper(ApiPurchaseBillDetails api) =>
      api.toDomain();

  @override
  @override
  Future<Result<bool>> loadMoreBills(int state) async {
    final response = await remote
        .getBills(page, pageSize, state)
        .handleRepository(apiBillsMapper);
    page++;
    return response.when((error) => Result.Error(error.message), (data) {
      cache.insertBills(
          data.map((e) => CachcedPurchaseBill.fromDomain(e)).toList());
      return Result.Success(data.length == pageSize);
    });
  }
}
