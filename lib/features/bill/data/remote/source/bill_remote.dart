import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/features/bill/data/remote/model/request/payment_request/payment_request..dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/bill_request.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_item.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_response.dart';
import 'package:car_part/features/bill/data/remote/source/bill_remote_abs.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/future_extention.dart';
import 'package:car_part/features/bill/data/remote/source/bill_api.dart';

class BillRemote implements IBillRemote {
  final api = Modular.get<DioClient>();
  final appPref = Modular.get<AppPref>();

  @override
  Future<ResponseResult<bool>> addBill(BillRequest request) =>
      api.dio.addBill(request).handleBoolRemote();

  @override
  Future<ResponseResult<bool>> addPayment(int billId, PaymentRequest request) =>
      api.dio.addPayment(billId, request).handleBoolRemote();

  @override
  Future<ResponseResult<ApiBillItem>> getBillDetails(int billId) =>
      api.dio.getBillDetails(billId).handleRemote(ApiBillItem.fromJson);

  @override
  Future<ResponseResult<ApiBillResponse>> getBills(
      int pageNumber, int pageSize, int? state) async {
    final storeId = await appPref.getInt(AppPref.storeId);
    if (storeId == null) throw NullThrownError();
    return api.dio
        .getBills(pageNumber, pageSize, storeId, state)
        .handleRemote(ApiBillResponse.fromJson, isList: true);
  }

  @override
  Future<ResponseResult<bool>> updateBills(int billId, BillRequest request) =>
      api.dio.updateBill(billId, request).handleBoolRemote();
}
