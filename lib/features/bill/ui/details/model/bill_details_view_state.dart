import 'package:car_part/common/network/errors/app_error.dart';
import 'package:car_part/common/ui/Event.dart';
import 'package:car_part/features/bill/data/domain/model/bill_product.dart';
import 'package:car_part/features/bill/ui/details/model/bill_details_navigation.dart';
import 'package:car_part/features/bill/ui/details/model/ui_details_view.dart';
import 'package:car_part/common/extention/string_extension.dart';
import 'package:car_part/common/extention/iterable_ext.dart';

class BillDetailsViewState {
  final Event<bool?> loading;
  final Event<UiError?> error;
  final Event<BillDetailsNavigation?> navigate;
  final UiBillDetails? uiBill;

  BillDetailsViewState(this.loading, this.error, this.navigate, this.uiBill);

  BillDetailsViewState copy(
          {Event<bool?>? loading,
          Event<UiError?>? error,
          Event<BillDetailsNavigation?>? navigate,
          UiBillDetails? uiBill}) =>
      BillDetailsViewState(
        loading ?? this.loading,
        error ?? this.error,
        navigate ?? this.navigate,
        uiBill ?? this.uiBill,
      );

  static BillDetailsViewState initViewState() =>
      BillDetailsViewState(Event(null), Event(null), Event(null), null);

  BillDetailsViewState updateLoading() => copy(loading: Event(true));

  BillDetailsViewState updateError(UiError error) =>
      copy(loading: Event(false), error: Event(error));

  BillDetailsViewState navigateTo(BillDetailsNavigation navigation) =>
      copy(navigate: Event(navigation));

  BillDetailsViewState updateBillDetails(UiBillDetails uiBill) =>
      copy(loading: Event(false), uiBill: uiBill);

  BillDetailsViewState updateQuantity(int productId, String quantity) {
    if (uiBill == null) return this;
    final index = uiBill!.products
        .indexWhere((element) => element.productId == productId);
    final q = quantity.toInt() ?? 0;
    final products = uiBill!.products;
    final newProduct = products[index].copyWith(quantity: q);
    products[index] = newProduct;
    return _updateBillData(products);
  }

  BillDetailsViewState updatePrice(int productId, String price) {
    if (uiBill == null) return this;
    final index = uiBill!.products
        .indexWhere((element) => element.productId == productId);
    final p = price.toDouble() ?? 0.0;
    final products = uiBill!.products;
    final newProduct = products[index].copyWith(price: p);
    products[index] = newProduct;
    return _updateBillData(products);
  }

  BillDetailsViewState _updateBillData(List<BillProduct> products) {
    double subTotal = products.map((e) => e.price * e.quantity).sum(0.0);
    double vat = subTotal * 0.15;
    return copy(
        uiBill: uiBill!.copy(vat: vat, subTotal: subTotal, products: products));
  }

  BillDetailsViewState onDeleteProdcut(int productId) {
    if (uiBill == null) return this;
    uiBill!.products.removeWhere((element) => element.productId == productId);
    return _updateBillData(uiBill!.products);
  }

  BillDetailsViewState onAddProdcut(BillProduct product) {
    if (uiBill == null) return this;
    uiBill!.products.add(product);
    return _updateBillData(uiBill!.products);
  }
}
