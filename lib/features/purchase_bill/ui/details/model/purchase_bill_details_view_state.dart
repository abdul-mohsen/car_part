import 'package:car_part/common/network/errors/app_error.dart';
import 'package:car_part/common/ui/Event.dart';
import 'package:car_part/common/extention/string_extension.dart';
import 'package:car_part/common/extention/iterable_ext.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_product.dart';
import 'package:car_part/features/purchase_bill/ui/details/model/purchase_bill_details_navigation.dart';
import 'package:car_part/features/purchase_bill/ui/details/model/ui_purchase_bill_details_view.dart';

class PurchaseBillDetailsViewState {
  final Event<bool?> loading;
  final Event<UiError?> error;
  final Event<PurchaseBillDetailsNavigation?> navigate;
  final UiPurchaseBillDetails? uiBill;

  PurchaseBillDetailsViewState(
      this.loading, this.error, this.navigate, this.uiBill);

  PurchaseBillDetailsViewState copy(
          {Event<bool?>? loading,
          Event<UiError?>? error,
          Event<PurchaseBillDetailsNavigation?>? navigate,
          UiPurchaseBillDetails? uiBill}) =>
      PurchaseBillDetailsViewState(
        loading ?? this.loading,
        error ?? this.error,
        navigate ?? this.navigate,
        uiBill ?? this.uiBill,
      );

  static PurchaseBillDetailsViewState initViewState() =>
      PurchaseBillDetailsViewState(Event(null), Event(null), Event(null), null);

  PurchaseBillDetailsViewState updateLoading() => copy(loading: Event(true));

  PurchaseBillDetailsViewState updateError(UiError error) =>
      copy(loading: Event(false), error: Event(error));

  PurchaseBillDetailsViewState navigateTo(
          PurchaseBillDetailsNavigation navigation) =>
      copy(navigate: Event(navigation));

  PurchaseBillDetailsViewState updateBillDetails(
          UiPurchaseBillDetails uiBill) =>
      copy(loading: Event(false), uiBill: uiBill);

  PurchaseBillDetailsViewState updateQuantity(int productId, String quantity) {
    if (uiBill == null) return this;
    final index = uiBill!.products
        .indexWhere((element) => element.productId == productId);
    final q = quantity.toInt() ?? 0;
    final products = uiBill!.products;
    final newProduct = products[index].copyWith(quantity: q);
    products[index] = newProduct;
    return _updateBillData(products);
  }

  PurchaseBillDetailsViewState updatePrice(int productId, String price) {
    if (uiBill == null) return this;
    final index = uiBill!.products
        .indexWhere((element) => element.productId == productId);
    final p = price.toDouble() ?? 0.0;
    final products = uiBill!.products;
    final newProduct = products[index].copyWith(price: p);
    products[index] = newProduct;
    return _updateBillData(products);
  }

  PurchaseBillDetailsViewState _updateBillData(
      List<PurchaseBillProduct> products) {
    double subTotal = products.map((e) => e.price * e.quantity).sum(0.0);
    double vat = subTotal * 0.15;
    return copy(
        uiBill: uiBill!.copy(vat: vat, subTotal: subTotal, products: products));
  }

  PurchaseBillDetailsViewState onDeleteProdcut(int productId) {
    if (uiBill == null) return this;
    uiBill!.products.removeWhere((element) => element.productId == productId);
    return _updateBillData(uiBill!.products);
  }

  PurchaseBillDetailsViewState onAddProdcut(PurchaseBillProduct product) {
    if (uiBill == null) return this;
    uiBill!.products.add(product);
    return _updateBillData(uiBill!.products);
  }
}
