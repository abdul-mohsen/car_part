import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_details.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purcahse_bill.dart';
import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/purchase_bill/data/domain/repository/purchase_bill_repository_abs.dart';
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

  @override
  Future<Result<bool>> addBill(PurchaseBillRequest request) =>
      remote.addBill(request).handleRepository((p0) => true);

  @override
  Future<Result<bool>> addPayment(int billId, PurchasePaymentRequest request) =>
      remote.addPayment(billId, request).handleRepository((p0) => true);

  @override
  Future<Result<bool>> deleteBill(int billId) =>
      remote.deleteBill(billId).handleRepository((p0) => true);

  @override
  Future<Result<PurchaseBillDetails>> getBillDetails(int billId) =>
      remote.getBillDetails(billId).handleRepository(apiBillDetailsMapper);

  @override
  Stream<Result<List<PurchaseBill>>> getBills(
          int pageNumber, int pageSize, int? state) =>
      remote
          .getBills(pageNumber, pageSize, state)
          .handleRepository(apiBillsMapper)
          .asStream();

  @override
  Future<Result<bool>> updateBills(int billId, PurchaseBillRequest request) =>
      remote.updateBills(billId, request).handleRepository((p0) => true);

  List<PurchaseBill> apiBillsMapper(ApiPurchaseBillResponse api) =>
      api.data.or([]).map((item) => apiBillMapper(item)).toList();

  PurchaseBill apiBillMapper(ApiPurchaseBillItem api) => api.toDomain();

  PurchaseBillDetails apiBillDetailsMapper(ApiPurchaseBillDetails api) =>
      api.toDomain();
}
