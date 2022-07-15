import 'package:car_part/common/cache/database/database.dart';

abstract class ICacheBill {
  Future<void> insertBills(List<cache_bill> cachedBills);
  Future<void> updateBill(cache_bill cachedBill);
  Future<void> insertBill(cache_bill cachedBill);
  Future<void> deleteAllBill();
  Future<void> deleteBill(int billId);
  Stream<List<cache_bill>> getBills();
}
