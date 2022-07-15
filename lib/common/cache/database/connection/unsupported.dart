import 'package:drift/drift.dart';

LazyDatabase openConnection({bool logStatements = false}) {
  throw UnsupportedError(
      'No suitable database implementation was found on this platform.');
}
