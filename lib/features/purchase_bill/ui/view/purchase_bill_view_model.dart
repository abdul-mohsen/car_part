import 'dart:async';

import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/bill/ui/view/model/bill_view_state.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseBillViewModel extends ViewModel {
  final _viewState =
      BehaviorSubject<BillViewState>.seeded(BillViewState.initViewState());
  Stream<BillViewState> get viewState => _viewState;

  @override
  void dispose() {
    super.dispose();
    _viewState.close();
  }
}
