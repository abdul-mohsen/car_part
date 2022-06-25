import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/network/dio_client.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_response/api_purchase_bill_item.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_response/api_purchase_bill_response.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_details/api_purchase_bill_details.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_payment_request.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_bill_request/purchase_bill_request.dart';
import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/purchase_bill/data/remote/source/purchase_bill_remote_abs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/features/purchase_bill/data/remote/source/purchase_bill_api.dart';
import 'package:car_part/common/extention/future_extention.dart';

class PurchaseBillRemote implements IPurchaseBillRemote {
  final api = Modular.get<DioClient>();
  final appPref = Modular.get<AppPref>();

  @override
  Future<ResponseResult<bool>> addBill(PurchaseBillRequest request) =>
      api.dio.addBill(request).handleBoolRemote();

  @override
  Future<ResponseResult<bool>> addPayment(
          int billId, PurchasePaymentRequest request) =>
      api.dio.addPayment(billId, request).handleBoolRemote();

  @override
  Future<ResponseResult<bool>> deleteBill(int billId) async {
    final storeId = await appPref.getInt(AppPref.storeId) ?? 1;
    if (storeId == null) throw NullThrownError();

    return api.dio.deleteBill(billId, storeId).handleBoolRemote();
  }

  @override
  Future<ResponseResult<ApiPurchaseBillDetails>> getBillDetails(int billId) =>
      api.dio
          .getBillDetails(billId)
          .handleRemote(ApiPurchaseBillDetails.fromJson);

  @override
  Future<ResponseResult<ApiPurchaseBillResponse>> getBills(
      int pageNumber, int pageSize, int? state) async {
    final storeId = await appPref.getInt(AppPref.storeId) ?? 1;
    if (storeId == null) throw NullThrownError();

    return api.dio
        .getBills(pageNumber, pageSize, storeId, state)
        .handleRemote(ApiPurchaseBillResponse.fromJson, isList: true);
  }

  @override
  Future<ResponseResult<bool>> updateBills(
          int billId, PurchaseBillRequest request) =>
      api.dio.updateBill(billId, request).handleBoolRemote();
}
