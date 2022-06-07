import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/extention/future_extention.dart';
import 'package:car_part/features/bill/data/domain/model/bill.dart';
import 'package:car_part/features/bill/data/domain/model/bill_details.dart';
import 'package:car_part/features/bill/data/domain/repository/bill_repository_abs.dart';
import 'package:car_part/features/bill/data/remote/model/request/payment_request/payment_request.dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/bill_request.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_details_response/api_bill_details.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_item.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_response.dart';
import 'package:car_part/features/bill/data/remote/source/bill_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BillRepository implements IBillRepository {
  final remote = Modular.get<IBillRemote>();

  @override
  Future<Result<bool>> addBill(BillRequest request) =>
      remote.addBill(request).handleRepository(
            (p0) => true,
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
  Stream<Result<List<Bill>>> getBills(
          int pageNumber, int pageSize, int? state) =>
      remote
          .getBills(pageNumber, pageSize, state)
          .handleRepository(apiBillsMapper)
          .asStream();

  @override
  Future<Result<bool>> updateBills(int billId, BillRequest request) =>
      remote.updateBills(billId, request).handleRepository((p0) => true);

  List<Bill> apiBillsMapper(ApiBillResponse api) =>
      api.data.or([]).map((item) => apiBillMapper(item)).toList();

  Bill apiBillMapper(ApiBillItem api) => api.toDomain();

  BillDetails apiBillDetailsMapper(ApiBillDetails api) => api.toDomain();

  @override
  Future<Result<bool>> deleteBill(int billId) =>
      remote.deleteBill(billId).handleRepository((p0) => true);
}
