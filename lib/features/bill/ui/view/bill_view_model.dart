import 'dart:async';

import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/bill/data/domain/model/bill.dart';
import 'package:car_part/features/bill/data/domain/repository/bill_repository_abs.dart';
import 'package:car_part/features/bill/ui/view/model/bill_navigation.dart';
import 'package:car_part/features/bill/ui/view/model/bill_view_state.dart';
import 'package:car_part/features/bill/ui/view/model/ui_bill_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class BillViewModel extends ViewModel {
  final _viewState =
      BehaviorSubject<BillViewState>.seeded(BillViewState.initViewState());
  Stream<BillViewState> get viewState => _viewState;

  final _repo = Modular.get<IBillRepository>();
  var pageNumber = 0;
  static const _pageSize = 25;
  static const _state = 1;
  var _listEnd = false;

  BillViewModel() {
    loadBills();
  }

  void loadBills() {
    if (_listEnd) return;
    _viewState.add(_viewState.value.updateLoading());
    _repo.getBills(pageNumber, _pageSize, _state).listen((event) {
      event.when((error) {
        _viewState.add(_viewState.value.updateError(error));
        return error;
      }, (data) {
        _viewState.add(_viewState.value
            .updateBills(data.map((e) => _fromDomain(e)).toList()));
        _listEnd = data.length < _pageSize;
        pageNumber++;
      });
    });
  }

  void navigateToDetails(int id) {
    _viewState.add(_viewState.value
        .navigateTo(BillViewNavigation.billDetails)
        .updateTargetId(id));
  }

  void createNewBill() {
    _viewState.add(_viewState.value.navigateTo(BillViewNavigation.billDetails));
  }

  UiBillView _fromDomain(Bill bill) => UiBillView(
      id: bill.id,
      discount: bill.discount,
      maintenanceCost: bill.maintenanceCost,
      note: bill.note,
      subTotal: bill.subTotal,
      vat: bill.vat,
      userName: bill.userName,
      userPhoneNumber: bill.userPhoneNumber);

  void deleteBill(int id) async {
    final result = await _repo.deleteBill(id);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
      return error;
    }, (data) => _viewState);
  }
}
