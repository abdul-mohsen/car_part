import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/extention/future_extention.dart';
import 'package:car_part/common/ui/event.dart';
import 'package:car_part/features/bill/data/domain/model/bill.dart';
import 'package:car_part/features/bill/data/domain/model/bill_details.dart';
import 'package:car_part/features/bill/data/domain/repository/bill_repository_abs.dart';
import 'package:car_part/features/bill/data/local/model/cached_bill.dart';
import 'package:car_part/features/bill/data/local/source/cache_bill_abs.dart';
import 'package:car_part/features/bill/data/remote/model/request/payment_request/payment_request.dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/bill_request.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_details_response/api_bill_details.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_item.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_response.dart';
import 'package:car_part/features/bill/data/remote/source/bill_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BillRepository implements IBillRepository {
  final remote = Modular.get<IBillRemote>();
  final cache = Modular.get<ICacheBill>();
  int page = 0;
  final pageSize = 20;

  @override
  Future<Result<bool>> addBill(BillRequest request) =>
      remote.addBill(request).handleRepository(
        (response) {
          final toDomain = apiBillMapper(response);
          cache.insertBill(CachedBill.fromDomain(toDomain));
          return true;
        },
      );

  @override
  Future<Result<bool>> addPayment(int billId, PaymentRequest request) =>
      remote.addPayment(billId, request).handleRepository(
            (p0) => true,
          );

  @override
  Future<Result<BillDetails>> getBillDetails(int billId) =>
      remote.getBillDetails(billId).handleRepository(apiBillDetailsMapper);

  @override
  Stream<List<Bill>> getBills() => cache.getBills().map((data) {
        page = (data.length / pageSize).floor();
        return data.map((e) => CachedBill.mapToDomain(e)).toList();
      });

  @override
  Future<Result<bool>> updateBills(int billId, BillRequest request) async {
    cache.deleteBill(billId);
    return remote.updateBills(billId, request).handleRepository((response) {
      final toDomain = apiBillMapper(response);
      cache.insertBill(CachedBill.fromDomain(toDomain));
      return true;
    });
  }

  List<Bill> apiBillsMapper(ApiBillResponse api) =>
      api.data.or([]).map((item) => apiBillMapper(item)).toList();

  Bill apiBillMapper(ApiBillItem api) => api.toDomain();

  BillDetails apiBillDetailsMapper(ApiBillDetails api) => api.toDomain();

  @override
  Future<Result<bool>> deleteBill(int billId) =>
      remote.deleteBill(billId).handleRepository((p0) {
        cache.deleteBill(billId);
        return true;
      });

  @override
  Future<Result<bool>> loadMoreBills(int state) async {
    final response = await remote
        .getBills(page, pageSize, state)
        .handleRepository(apiBillsMapper);
    return response.when((error) => Result.Error(error.message), (data) {
      cache.insertBills(data.map((e) => CachedBill.fromDomain(e)).toList());
      return Result.Success(data.length == pageSize);
    });
  }
}
