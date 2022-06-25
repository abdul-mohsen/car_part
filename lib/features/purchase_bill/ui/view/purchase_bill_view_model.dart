import 'dart:async';

import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purcahse_bill.dart';
import 'package:car_part/features/purchase_bill/data/domain/repository/purchase_bill_repository_abs.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/purchase_bill_view_navigation.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/purchase_bill_view_state.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/ui_purchase_bill_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseBillViewModel extends ViewModel {
  final _viewState = BehaviorSubject<PurchaseBillViewState>.seeded(
      PurchaseBillViewState.initViewState());
  Stream<PurchaseBillViewState> get viewState => _viewState;

  final _repo = Modular.get<IPurchaseBillRepository>();
  var pageNumber = 0;
  static const _pageSize = 25;
  static const _state = 1;
  var _listEnd = false;

  @override
  void init() {
    loadBills();
    super.init();
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
        .navigateTo(PurcahseBillViewNavigation.billDetails)
        .updateTargetId(id));
  }

  void createNewBill() {
    _viewState.add(
        _viewState.value.navigateTo(PurcahseBillViewNavigation.billDetails));
  }

  UiPurchaseBillView _fromDomain(PurchaseBill bill) => UiPurchaseBillView(
      id: bill.id,
      discount: bill.discount,
      subTotal: bill.subTotal,
      vat: bill.vat,
      supplierId: bill.supplierId?.toString() ?? "-",
      supplierSequenceNumber: bill.supplierSequenceNumber?.toString() ?? "-");

  void deleteBill(int id) async {
    final result = await _repo.deleteBill(id);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
      return error;
    }, (data) => _viewState);
  }
}
