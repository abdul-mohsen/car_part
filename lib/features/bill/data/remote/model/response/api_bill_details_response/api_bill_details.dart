import 'package:car_part/features/bill/data/domain/model/bill_details.dart';
import 'package:car_part/features/bill/data/remote/model/response/api_bill_details_response/api_bill_product_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/extention/string_extension.dart';

part 'api_bill_details.g.dart';

@JsonSerializable()
class ApiBillDetails {
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
  final List<ApiBillProductItem>? product;

  const ApiBillDetails({
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
    this.product,
  });

  @override
  String toString() {
    return 'Data(id: $id, effectiveDate: $effectiveDate, paymentDueDate: $paymentDueDate, state: $state, subTotal: $subTotal, discount: $discount, vat: $vat, sequenceNumber: $sequenceNumber, storeId: $storeId, merchantId: $merchantId, maintenanceCost: $maintenanceCost, note: $note, userName: $userName, userPhoneNumber: $userPhoneNumber, product: $product)';
  }

  factory ApiBillDetails.fromJson(Map<String, dynamic> json) =>
      _$ApiBillDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ApiBillDetailsToJson(this);

  BillDetails toDomain() => BillDetails(
      id: id.throwIfNull(),
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
      vat: vat?.toDouble() ?? 0.0,
      products: product.or([]).map((e) => e.toDomain()).toList());
}
