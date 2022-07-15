import 'package:car_part/common/cache/database/database.dart';

abstract class ICachePurchaseBill {
  Future<void> insertBills(List<cache_purchase_bill> cachedBills);
  Future<void> updateBill(cache_purchase_bill cachedBill);
  Future<void> insertBill(cache_purchase_bill cachedBill);
  Future<void> deleteAllBill();
  Future<void> deleteBill(int billId);
  Stream<List<cache_purchase_bill>> getBills();
}
