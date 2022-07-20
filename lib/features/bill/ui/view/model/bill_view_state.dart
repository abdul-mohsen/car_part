import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/network/errors/app_error.dart';
import 'package:car_part/common/ui/Event.dart';
import 'package:car_part/features/bill/ui/view/model/bill_navigation.dart';
import 'package:car_part/features/bill/ui/view/model/ui_bill_view.dart';

class BillViewState {
  final Event<bool?> loading;
  final Event<UiError?> error;
  final Event<BillViewNavigation?> navigate;
  final List<UiBillView> uiBills;
  final Event<int?> targerBillId;

  BillViewState(
      this.loading, this.error, this.navigate, this.uiBills, this.targerBillId);
  factory BillViewState.creat(
          bool? loading,
          UiError? error,
          BillViewNavigation? navigate,
          List<UiBillView>? uiBills,
          int? targerBillId) =>
      BillViewState(Event(loading), Event(error), Event(navigate),
          uiBills.or([]), Event(targerBillId));

  BillViewState copy(
      {Event<bool?>? loading,
      Event<UiError?>? error,
      Event<BillViewNavigation?>? navigate,
      List<UiBillView>? uiBills,
      Event<int?>? targerBillId}) {
    return BillViewState(
        loading ?? this.loading,
        error ?? this.error,
        navigate ?? this.navigate,
        uiBills ?? this.uiBills,
        targerBillId ?? this.targerBillId);
  }

  static BillViewState initViewState() =>
      BillViewState.creat(null, null, null, null, null);

  BillViewState updateLoading({loading = true}) =>
      copy(loading: Event(loading));

  BillViewState updateError(UiError error) =>
      copy(loading: Event(false), error: Event(error));

  BillViewState navigateTo(BillViewNavigation navigation) =>
      copy(navigate: Event(navigation));

  BillViewState updateBills(List<UiBillView> uiBills) =>
      copy(loading: Event(false), uiBills: uiBills);

  BillViewState updateTargetId(int id) => copy(targerBillId: Event(id));

  BillViewState deleteBill(id) {
    uiBills.removeWhere((element) => element.id == id);
    return updateBills(uiBills);
  }
}
