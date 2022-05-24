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

  BillViewState(this.loading, this.error, this.navigate, this.uiBills);
  factory BillViewState.creat(bool? loading, UiError? error,
          BillViewNavigation? navigate, List<UiBillView>? uiBills) =>
      BillViewState(
          Event(loading), Event(error), Event(navigate), uiBills.or([]));

  BillViewState copy(
      {Event<bool?>? loading,
      Event<UiError?>? error,
      Event<BillViewNavigation?>? navigate,
      List<UiBillView>? uiBills}) {
    return BillViewState(
      loading ?? this.loading,
      error ?? this.error,
      navigate ?? this.navigate,
      uiBills ?? this.uiBills,
    );
  }

  static BillViewState initViewState() =>
      BillViewState.creat(null, null, null, null);

  BillViewState updateLoading() => copy(loading: Event(true));

  BillViewState updateError(UiError error) =>
      copy(loading: Event(false), error: Event(error));

  BillViewState navigateTo(BillViewNavigation navigation) =>
      copy(navigate: Event(navigation));

  BillViewState updateBills(List<UiBillView> uiBills) =>
      copy(loading: Event(false), uiBills: this.uiBills + uiBills);
}
