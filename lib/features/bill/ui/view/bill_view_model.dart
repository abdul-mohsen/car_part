import 'dart:async';

import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/bill/data/domain/model/bill.dart';
import 'package:car_part/features/bill/data/domain/repository/bill_repository_abs.dart';
import 'package:car_part/features/bill/ui/view/model/bill_view_state.dart';
import 'package:car_part/features/bill/ui/view/model/ui_bill_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class BullViewModel extends ViewModel {
  final _viewState =
      BehaviorSubject<BillViewState>.seeded(BillViewState.initViewState());
  Stream<BillViewState> get viewState => _viewState;

  final _repo = Modular.get<IBillRepository>();

  void loadBills(int pageNumber) {
    _viewState.add(_viewState.value.updateLoading());
    _repo.getBills(pageNumber, 10, 1).listen((event) {
      event.when((error) {
        _viewState.add(_viewState.value.updateError(error));
        return error;
      },
          (data) => _viewState.value
              .updateBills(data.map((e) => _fromDomain(e)).toList()));
    });
  }

  UiBillView _fromDomain(Bill bill) => UiBillView(
      id: bill.id,
      effectiveDate: bill.effectiveDate,
      sequenceNumber: bill.sequenceNumber,
      userName: bill.userName,
      userPhoneNumber: bill.userPhoneNumber);

  @override
  void dispose() {
    super.dispose();
    _viewState.close();
  }
}
