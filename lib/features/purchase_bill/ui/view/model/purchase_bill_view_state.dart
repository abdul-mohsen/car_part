import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/network/errors/app_error.dart';
import 'package:car_part/common/ui/Event.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/purchase_bill_view_navigation.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/ui_purchase_bill_view.dart';

class PurchaseBillViewState {
  final Event<bool?> loading;
  final Event<UiError?> error;
  final Event<PurcahseBillViewNavigation?> navigate;
  final List<UiPurchaseBillView> uiBills;
  final Event<int?> targerBillId;

  PurchaseBillViewState(
      this.loading, this.error, this.navigate, this.uiBills, this.targerBillId);
  factory PurchaseBillViewState.creat(
          bool? loading,
          UiError? error,
          PurcahseBillViewNavigation? navigate,
          List<UiPurchaseBillView>? uiBills,
          int? targerBillId) =>
      PurchaseBillViewState(Event(loading), Event(error), Event(navigate),
          uiBills.or([]), Event(targerBillId));

  PurchaseBillViewState copy(
      {Event<bool?>? loading,
      Event<UiError?>? error,
      Event<PurcahseBillViewNavigation?>? navigate,
      List<UiPurchaseBillView>? uiBills,
      Event<int?>? targerBillId}) {
    return PurchaseBillViewState(
        loading ?? this.loading,
        error ?? this.error,
        navigate ?? this.navigate,
        uiBills ?? this.uiBills,
        targerBillId ?? this.targerBillId);
  }

  static PurchaseBillViewState initViewState() =>
      PurchaseBillViewState.creat(null, null, null, null, null);

  PurchaseBillViewState updateLoading() => copy(loading: Event(true));

  PurchaseBillViewState updateError(UiError error) =>
      copy(loading: Event(false), error: Event(error));

  PurchaseBillViewState navigateTo(PurcahseBillViewNavigation navigation) =>
      copy(navigate: Event(navigation));

  PurchaseBillViewState updateBills(List<UiPurchaseBillView> uiBills) =>
      copy(loading: Event(false), uiBills: uiBills);

  PurchaseBillViewState updateTargetId(int id) => copy(targerBillId: Event(id));

  PurchaseBillViewState deleteBill(id) {
    uiBills.removeWhere((element) => element.id == id);
    return updateBills(uiBills);
  }
}
