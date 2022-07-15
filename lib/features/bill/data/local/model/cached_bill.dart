import 'package:car_part/common/cache/database/database.dart';
import 'package:car_part/features/bill/data/domain/model/bill.dart';
import 'package:drift/drift.dart';

@DataClassName('cache_bill')
class CachedBill extends Table {
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
  RealColumn get maintenanceCost => real()();
  TextColumn get note => text()();
  TextColumn get userName => text()();
  TextColumn get userPhoneNumber => text()();

  @override
  Set<Column> get primaryKey => {id};

  static Bill mapToDomain(cache_bill cached) => Bill(
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
      maintenanceCost: cached.maintenanceCost,
      note: cached.note,
      userName: cached.userName,
      userPhoneNumber: cached.userPhoneNumber);

  static cache_bill fromDomain(Bill domain) => cache_bill(
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
      maintenanceCost: domain.maintenanceCost,
      note: domain.note,
      userName: domain.userName,
      userPhoneNumber: domain.userPhoneNumber);
}
