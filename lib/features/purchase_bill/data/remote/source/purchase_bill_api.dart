import 'package:car_part/common/network/end_point.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_bill_request/purchase_bill_request.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_payment_request.dart';
import 'package:dio/dio.dart';

extension BillApi on Dio {
  Future<Response<Map<String, dynamic>?>> getBills(
          int pageNumber, int pageSize, int storeId, int? state) =>
      get(EndPoints.purchaseRegister, queryParameters: {
        'page': pageNumber,
        'pageSize': pageSize,
        'storeId': storeId,
        'state': state
      });

  Future<Response<Map<String, dynamic>?>> getBillDetails(int billId) =>
      get("${EndPoints.purchaseRegister}/$billId");

  Future<Response<Map<String, dynamic>?>> addBill(
          PurchaseBillRequest request) =>
      post(EndPoints.purchaseRegister, data: request.toJson());

  Future<Response<Map<String, dynamic>?>> updateBill(
          int billId, PurchaseBillRequest request) =>
      put("${EndPoints.purchaseRegister}/$billId", data: request.toJson());

  Future<Response<Map<String, dynamic>?>> addPayment(
          int billId, PurchasePaymentRequest request) =>
      post("${EndPoints.purchaseRegister}/$billId", data: request.toJson());

  Future<Response<Map<String, dynamic>?>> deleteBill(int billId) =>
      delete("${EndPoints.purchaseRegister}/$billId");
}
