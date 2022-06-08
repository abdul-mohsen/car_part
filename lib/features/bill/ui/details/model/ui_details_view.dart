import 'package:car_part/features/bill/data/domain/model/bill_product.dart';

class UiBillDetails {
  final int? id;
  final String effectiveDate;
  final String paymentDueDate;
  final int state;
  final double subTotal;
  final double discount;
  final double vat;
  final String sequenceNumber;
  final double maintenanceCost;
  final String note;
  final String userName;
  final String userPhoneNumber;
  final List<BillProduct> products;

  UiBillDetails(
      {required this.id,
      required this.effectiveDate,
      required this.paymentDueDate,
      required this.state,
      required this.subTotal,
      required this.discount,
      required this.vat,
      required this.sequenceNumber,
      required this.maintenanceCost,
      required this.note,
      required this.userName,
      required this.userPhoneNumber,
      required this.products});

  UiBillDetails copy({
    int? id,
    String? effectiveDate,
    String? paymentDueDate,
    int? state,
    double? subTotal,
    double? discount,
    double? vat,
    String? sequenceNumber,
    double? maintenanceCost,
    String? note,
    String? userName,
    String? userPhoneNumber,
    List<BillProduct>? products,
  }) =>
      UiBillDetails(
          id: id ?? this.id,
          effectiveDate: effectiveDate ?? this.effectiveDate,
          paymentDueDate: paymentDueDate ?? this.paymentDueDate,
          state: state ?? this.state,
          subTotal: subTotal ?? this.subTotal,
          discount: discount ?? this.discount,
          vat: vat ?? this.vat,
          sequenceNumber: sequenceNumber ?? this.sequenceNumber,
          maintenanceCost: maintenanceCost ?? this.maintenanceCost,
          note: note ?? this.note,
          userName: userName ?? this.userName,
          userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
          products: products ?? this.products);
}
