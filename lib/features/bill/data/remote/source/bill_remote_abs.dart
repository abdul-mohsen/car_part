import 'package:car_part/common/network/response_result.dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/bill_request.dart';
import 'package:car_part/features/bill/data/remote/model/request/payment_request/payment_request..dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_item.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_response/api_bill_response.dart';

abstract class IBillRemote {
  Future<ResponseResult<ApiBillResponse>> getBills(
      int pageNumber, int pageSize, int? state);

  Future<ResponseResult<bool>> addBill(BillRequest request);

  Future<ResponseResult<bool>> updateBills(int billId, BillRequest request);

  Future<ResponseResult<bool>> addPayment(int billId, PaymentRequest request);

  Future<ResponseResult<ApiBillItem>> getBillDetails(int billId);
}
