import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase openConnection({bool logStatements = false}) {
  return LazyDatabase(
      () async => WebDatabase('db', logStatements: logStatements));
}
