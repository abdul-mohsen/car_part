import 'package:car_part/common/cache/database/database.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purcahse_bill.dart';
import 'package:drift/drift.dart';

@DataClassName('cache_purchase_bill')
class CachcedPurchaseBill extends Table {
  IntColumn get id => integer()();
  TextColumn get effectiveDate => text()();
  TextColumn get paymentDueDate => text()();
  IntColumn get state => integer()();
  RealColumn get subTotal => real()();
  RealColumn get discount => real()();
  RealColumn get vat => real()();
  IntColumn get sequenceNumber => integer()();
  IntColumn get storeId => integer()();
  IntColumn get merchantId => integer()();
  IntColumn get supplierId => integer().nullable()();
  IntColumn get supplierSequenceNumber => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  static PurchaseBill mapToDomain(cache_purchase_bill cached) => PurchaseBill(
      id: cached.id,
      effectiveDate: cached.effectiveDate,
      paymentDueDate: cached.paymentDueDate,
      state: cached.state,
      subTotal: cached.subTotal,
      discount: cached.discount,
      vat: cached.vat,
      sequenceNumber: cached.sequenceNumber,
      storeId: cached.storeId,
      merchantId: cached.merchantId,
      supplierId: cached.supplierId,
      supplierSequenceNumber: cached.supplierSequenceNumber);

  static cache_purchase_bill fromDomain(PurchaseBill domain) =>
      cache_purchase_bill(
          id: domain.id,
          effectiveDate: domain.effectiveDate,
          paymentDueDate: domain.paymentDueDate,
          state: domain.state,
          subTotal: domain.subTotal,
          discount: domain.discount,
          vat: domain.vat,
          sequenceNumber: domain.sequenceNumber,
          storeId: domain.storeId,
          merchantId: domain.merchantId,
          supplierId: domain.supplierId,
          supplierSequenceNumber: domain.supplierSequenceNumber);
}
