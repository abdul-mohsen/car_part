import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/cache/database/database.dart';
import 'package:car_part/features/bill/data/local/source/cache_bill.dart';
import 'package:car_part/features/purchase_bill/data/local/source/cache_purchase_bill.dart';
import 'package:flutter_modular/flutter_modular.dart';

List<Bind> cacheInjection() {
  return [
    Bind.singleton((i) => AppPref()),
    Bind.singleton((i) => AppDatabase()),
    Bind.singleton((i) => CacheBill()),
    Bind.singleton(
      (i) => CachePurchaseBill(),
    )
  ];
}
