import 'package:car_part/common/domain/result.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purcahse_bill.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_details.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_bill_request/purchase_bill_request.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_payment_request.dart';

abstract class IPurchaseBillRepository {
  Stream<List<PurchaseBill>> getBills();

  Future<Result<bool>> addBill(PurchaseBillRequest request);

  Future<Result<bool>> updateBills(int billId, PurchaseBillRequest request);

  Future<Result<bool>> addPayment(int billId, PurchasePaymentRequest request);

  Future<Result<PurchaseBillDetails>> getBillDetails(int billId);

  Future<Result<bool>> deleteBill(int billId);

  Future<Result<bool>> loadMoreBills(int state);
}
