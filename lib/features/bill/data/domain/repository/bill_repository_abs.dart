import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/bill/data/domain/model/bill.dart';
import 'package:car_part/features/bill/data/domain/model/bill_details.dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/bill_request.dart';
import 'package:car_part/features/bill/data/remote/model/request/payment_request/payment_request.dart';

abstract class IBillRepository {
  Stream<Result<List<Bill>>> getBills(int pageNumber, int pageSize, int? state);

  Future<Result<bool>> addBill(BillRequest request);

  Future<Result<bool>> updateBills(int billId, BillRequest request);

  Future<Result<bool>> addPayment(int billId, PaymentRequest request);

  Future<Result<BillDetails>> getBillDetails(int billId);

  Future<Result<bool>> deleteBill(int billId);
}
