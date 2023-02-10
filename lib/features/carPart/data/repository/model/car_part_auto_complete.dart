import 'package:equatable/equatable.dart';

class CarPartAutoComplete extends Equatable {
  final int id;
  final String oemNumber;

  const CarPartAutoComplete({required this.id, required this.oemNumber});

  CarPartAutoComplete copyWith({
    int? id,
    String? oemNumber,
  }) {
    return CarPartAutoComplete(
      id: id ?? this.id,
      oemNumber: oemNumber ?? this.oemNumber,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, oemNumber];

  @override
  String toString() => oemNumber;
}
