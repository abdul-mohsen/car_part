import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_bill_request/purchase_bill_request.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_payment_request.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_details/api_purchase_bill_details.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/response/api_purchase_bill_response/api_purchase_bill_response.dart';

abstract class IPurchaseBillRemote {
  Future<ResponseResult<ApiPurchaseBillResponse>> getBills(
      int pageNumber, int pageSize, int? state);

  Future<ResponseResult<bool>> addBill(PurchaseBillRequest request);

  Future<ResponseResult<bool>> updateBills(
      int billId, PurchaseBillRequest request);

  Future<ResponseResult<bool>> addPayment(
      int billId, PurchasePaymentRequest request);

  Future<ResponseResult<ApiPurchaseBillDetails>> getBillDetails(int billId);

  Future<ResponseResult<bool>> deleteBill(int billId);
}
