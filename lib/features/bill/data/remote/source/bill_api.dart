import 'package:car_part/common/network/end_point.dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/bill_request.dart';
import 'package:car_part/features/bill/data/remote/model/request/payment_request/payment_request.dart';
import 'package:dio/dio.dart';

extension BillApi on Dio {
  Future<Response<Map<String, dynamic>?>> getBills(
          int pageNumber, int pageSize, int storeId, int? state) =>
      get(EndPoints.bills, queryParameters: {
        'page': pageNumber,
        'pageSize': pageSize,
        'storeId': storeId,
        'state': state
      });

  Future<Response<Map<String, dynamic>?>> getBillDetails(int billId) =>
      get("${EndPoints.bills}/$billId");

  Future<Response<Map<String, dynamic>?>> addBill(BillRequest request) =>
      post(EndPoints.bills, data: request.toJson());

  Future<Response<Map<String, dynamic>?>> updateBill(
          int billId, BillRequest request) =>
      put("${EndPoints.bills}/$billId", data: request.toJson());

  Future<Response<Map<String, dynamic>?>> addPayment(
          int billId, PaymentRequest request) =>
      post("${EndPoints.bills}/$billId", data: request.toJson());

  Future<Response<Map<String, dynamic>?>> deleteBill(int billId) =>
      delete("${EndPoints.bills}/$billId");
}
