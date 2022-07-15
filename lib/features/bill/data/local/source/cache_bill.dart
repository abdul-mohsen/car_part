import 'package:car_part/common/cache/database/database.dart';
import 'package:car_part/features/bill/data/local/source/cache_bill_abs.dart';
import 'package:drift/drift.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CacheBill extends ICacheBill {
  final database = Modular.get<AppDatabase>();
  $CachedBillTable get cachedBillTable => database.cachedBill;

  @override
  Future<void> deleteAllBill() async {
    database.delete(cachedBillTable).go();
  }

  @override
  Future<void> deleteBill(int billId) async {
    (database.delete(cachedBillTable)..where((tbl) => tbl.id.equals(billId)))
        .go();
  }

  @override
  Stream<List<cache_bill>> getBills() => (database.select(cachedBillTable)
        ..orderBy(
            [(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
      .watch();

  @override
  Future<void> insertBills(List<cache_bill> cachedBills) async {
    await database.batch((batch) {
      batch.insertAllOnConflictUpdate(cachedBillTable, cachedBills);
    });
  }

  @override
  Future<void> updateBill(cache_bill cachedBill) async {
    (database.update(cachedBillTable)
          ..where((tbl) => tbl.id.equals(cachedBill.id)))
        .write(cachedBill);
  }

  @override
  Future<void> insertBill(cache_bill cachedBill) async {
    database.into(cachedBillTable).insert(cachedBill);
  }
}
