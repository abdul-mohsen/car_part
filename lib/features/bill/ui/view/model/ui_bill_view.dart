import 'package:car_part/features/bill/data/domain/model/bill.dart';

class UiBillView {
  final int id;
  final String effectiveDate;
  final int sequenceNumber;
  final String userName;
  final String userPhoneNumber;

  const UiBillView(
      {required this.id,
      required this.effectiveDate,
      required this.sequenceNumber,
      required this.userName,
      required this.userPhoneNumber});
}
