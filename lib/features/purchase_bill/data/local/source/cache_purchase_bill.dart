import 'package:car_part/common/cache/database/database.dart';
import 'package:car_part/features/purchase_bill/data/local/source/cache_purchase_bill_abs.dart';
import 'package:drift/drift.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CachePurchaseBill extends ICachePurchaseBill {
  final database = Modular.get<AppDatabase>();
  $CachcedPurchaseBillTable get cachedPurchaseBillTable =>
      database.cachcedPurchaseBill;

  @override
  Future<void> deleteAllBill() async {
    database.delete(cachedPurchaseBillTable).go();
  }

  @override
  Future<void> deleteBill(int billId) async {
    (database.delete(cachedPurchaseBillTable)
          ..where((tbl) => tbl.id.equals(billId)))
        .go();
  }

  @override
  Stream<List<cache_purchase_bill>> getBills() => (database
          .select(cachedPurchaseBillTable)
        ..orderBy(
            [(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
      .watch();

  @override
  Future<void> insertBills(List<cache_purchase_bill> cachedBills) async {
    await database.batch((batch) {
      batch.insertAllOnConflictUpdate(cachedPurchaseBillTable, cachedBills);
    });
  }

  @override
  Future<void> updateBill(cache_purchase_bill cachedBill) async {
    (database.update(cachedPurchaseBillTable)
          ..where((tbl) => tbl.id.equals(cachedBill.id)))
        .write(cachedBill);
  }

  @override
  Future<void> insertBill(cache_purchase_bill cachedBill) async {
    database.into(cachedPurchaseBillTable).insert(cachedBill);
  }
}
