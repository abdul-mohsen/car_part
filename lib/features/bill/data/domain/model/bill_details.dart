import 'package:car_part/features/bill/data/domain/model/bill_product.dart';
import 'package:equatable/equatable.dart';

class BillDetails extends Equatable {
  final int id;
  final String? effectiveDate;
  final String? paymentDueDate;
  final int state;
  final double? subTotal;
  final double? discount;
  final double vat;
  final int? sequenceNumber;
  final int? storeId;
  final int? merchantId;
  final double? maintenanceCost;
  final String? note;
  final String? userName;
  final String? userPhoneNumber;
  final List<BillProduct> products;

  const BillDetails(
      {required this.id,
      required this.effectiveDate,
      required this.paymentDueDate,
      required this.state,
      required this.subTotal,
      required this.discount,
      required this.vat,
      required this.sequenceNumber,
      required this.storeId,
      required this.merchantId,
      required this.maintenanceCost,
      required this.note,
      required this.userName,
      required this.userPhoneNumber,
      required this.products});

  BillDetails copyWith(
      {final int? id,
      final String? effectiveDate,
      final String? paymentDueDate,
      final int? state,
      final double? subTotal,
      final double? discount,
      final double? vat,
      final int? sequenceNumber,
      final int? storeId,
      final int? merchantId,
      final double? maintenanceCost,
      final String? note,
      final String? userName,
      final String? userPhoneNumber,
      final List<BillProduct>? products}) {
    return BillDetails(
        id: id ?? this.id,
        effectiveDate: effectiveDate ?? this.effectiveDate,
        paymentDueDate: paymentDueDate ?? this.paymentDueDate,
        state: state ?? this.state,
        subTotal: subTotal ?? this.subTotal,
        discount: discount ?? this.discount,
        vat: vat ?? this.vat,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
        storeId: storeId ?? this.storeId,
        merchantId: merchantId ?? this.merchantId,
        maintenanceCost: maintenanceCost ?? this.maintenanceCost,
        note: note ?? this.note,
        userName: userName ?? this.userName,
        userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
        products: products ?? this.products);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        effectiveDate,
        paymentDueDate,
        state,
        subTotal,
        discount,
        vat,
        sequenceNumber,
        storeId,
        merchantId,
        maintenanceCost,
        note,
        userName,
        userPhoneNumber,
        products
      ];
}
