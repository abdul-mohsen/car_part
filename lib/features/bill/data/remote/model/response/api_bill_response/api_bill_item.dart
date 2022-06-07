import 'package:car_part/features/bill/data/domain/model/bill.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/extention/string_extension.dart';

part 'api_bill_item.g.dart';

@JsonSerializable()
class ApiBillItem {
  final int? id;
  @JsonKey(name: 'effective_date')
  final String? effectiveDate;
  @JsonKey(name: 'payment_due_date')
  final String? paymentDueDate;
  final int? state;
  @JsonKey(name: 'sub_total')
  final String? subTotal;
  final String? discount;
  final String? vat;
  @JsonKey(name: 'sequence_number')
  final int? sequenceNumber;
  @JsonKey(name: 'store_id')
  final int? storeId;
  @JsonKey(name: 'merchant_id')
  final int? merchantId;
  @JsonKey(name: 'maintenance_cost')
  final String? maintenanceCost;
  final String? note;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'user_phone_number')
  final String? userPhoneNumber;

  const ApiBillItem({
    this.id,
    this.effectiveDate,
    this.paymentDueDate,
    this.state,
    this.subTotal,
    this.discount,
    this.vat,
    this.sequenceNumber,
    this.storeId,
    this.merchantId,
    this.maintenanceCost,
    this.note,
    this.userName,
    this.userPhoneNumber,
  });

  @override
  String toString() {
    return 'Datum(id: $id, effectiveDate: $effectiveDate, paymentDueDate: $paymentDueDate, state: $state, subTotal: $subTotal, discount: $discount, vat: $vat, sequenceNumber: $sequenceNumber, storeId: $storeId, merchantId: $merchantId, maintenanceCost: $maintenanceCost, note: $note, userName: $userName, userPhoneNumber: $userPhoneNumber)';
  }

  factory ApiBillItem.fromJson(Map<String, dynamic> json) =>
      _$ApiBillItemFromJson(json);

  Map<String, dynamic> toJson() => _$ApiBillItemToJson(this);

  Bill toDomain() => Bill(
      id: id.or(-1),
      discount: discount?.toDouble() ?? 0.0,
      effectiveDate: effectiveDate.or("-"),
      maintenanceCost: maintenanceCost?.toDouble() ?? 0.0,
      merchantId: merchantId.or(0),
      note: note.or(""),
      paymentDueDate: paymentDueDate.or("-"),
      sequenceNumber: sequenceNumber.or(0),
      state: state.or(0),
      storeId: storeId.or(0),
      subTotal: subTotal?.toDouble() ?? 0.0,
      userName: userName.or(""),
      userPhoneNumber: userPhoneNumber.or(""),
      vat: vat?.toDouble() ?? 0.0);
}
