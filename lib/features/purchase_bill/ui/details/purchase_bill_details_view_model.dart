import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/carPart/data/repository/car_part_repository_abs.dart';
import 'package:car_part/features/carPart/data/repository/model/car_part_auto_complete.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_details.dart';
import 'package:car_part/features/purchase_bill/data/domain/model/purchase_bill_product.dart';
import 'package:car_part/features/purchase_bill/data/domain/repository/purchase_bill_repository_abs.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_bill_request/purchase_bill_product_item.dart';
import 'package:car_part/features/purchase_bill/data/remote/model/request/purchase_bill_request/purchase_bill_request.dart';
import 'package:car_part/features/purchase_bill/ui/details/model/purchase_bill_details_navigation.dart';
import 'package:car_part/features/purchase_bill/ui/details/model/purchase_bill_details_view_state.dart';
import 'package:car_part/features/purchase_bill/ui/details/model/ui_purchase_bill_details_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseBillDetailsViewModel extends ViewModel {
  final _viewState = BehaviorSubject<PurchaseBillDetailsViewState>.seeded(
      PurchaseBillDetailsViewState.initViewState());
  Stream<PurchaseBillDetailsViewState> get viewState => _viewState;

  final _repo = Modular.get<IPurchaseBillRepository>();
  final _carPartAutoCompleteRepo = Modular.get<ICarPartRepository>();
  String? supplierId;
  String? supplierSequenceNumber;
  @override
  void init() {
    super.init();
    loadBill();
  }

  void onSupplierId(String? text) {
    supplierId = text;
  }

  void onSupplierSequenceNumber(String? text) {
    supplierSequenceNumber = text;
  }

  void loadBill() async {
    int? id = Modular.args.data;
    if (id == null) {
      _viewState.add(_viewState.value.updateBillDetails(UiPurchaseBillDetails(
          id: null,
          effectiveDate: "-",
          paymentDueDate: "-",
          state: 1,
          subTotal: 0,
          discount: 0,
          vat: 0,
          sequenceNumber: "",
          supplierId: "",
          supplierSequenceNumber: "",
          products: [])));
      return;
    }
    _viewState.add(_viewState.value.updateLoading());
    final result = await _repo.getBillDetails(id);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
    },
        (data) => _viewState
            .add(_viewState.value.updateBillDetails(_fromDomain(data))));
  }

  UiPurchaseBillDetails _fromDomain(PurchaseBillDetails bill) =>
      UiPurchaseBillDetails(
          id: bill.id,
          effectiveDate: bill.effectiveDate ?? "-",
          paymentDueDate: bill.paymentDueDate ?? "-",
          discount: bill.discount ?? 0.0,
          subTotal: bill.subTotal ?? 0.0,
          vat: bill.vat,
          sequenceNumber: bill.sequenceNumber?.toString() ?? "",
          state: bill.state,
          supplierId: bill.supplierId?.toString() ?? "",
          supplierSequenceNumber: bill.supplierSequenceNumber?.toString() ?? "",
          products: bill.products);

  void toAddProductsView() {
    _viewState.add(
        _viewState.value.navigateTo(PurchaseBillDetailsNavigation.addProducts));
  }

  void onQuantityChange(int index, String? quantity) {
    if (quantity == null) return;
    _viewState.add(_viewState.value.updateQuantity(index, quantity));
  }

  void onPriceChange(int index, String? price) {
    if (price == null) return;
    _viewState.add(_viewState.value.updatePrice(index, price));
  }

  void onDeleteProdcut(int productId) {
    _viewState.add(_viewState.value.onDeleteProdcut(productId));
  }

  Future<Result<List<CarPartAutoComplete>>> autoCompleteList(String query) =>
      _carPartAutoCompleteRepo.getCarPartAutoCompletelist(query);

  void onSelecteProduct(CarPartAutoComplete part) {
    PurchaseBillProduct product = PurchaseBillProduct(
        productId: part.id,
        partName: "-",
        partNumber: part.oemNumber,
        price: 0.0,
        quantity: 1);
    _viewState.add(_viewState.value.onAddProdcut(product));
  }

  void navigateBack() {
    _viewState
        .add(_viewState.value.navigateTo(PurchaseBillDetailsNavigation.back));
  }

  void saveData() {
    _submitData(supplierId, supplierSequenceNumber, 1);
  }

  void confirmData() {
    _submitData(supplierId, supplierSequenceNumber, 2);
  }

  void _submitData(
      String? supplierId, String? supplierSequenceNumber, int state) {
    final uiBill = _viewState.value.uiBill!;
    final billRequest = PurchaseBillRequest(
        state: state,
        discount: uiBill.discount.toString(),
        paidAmount: "0.0",
        paymentDate: null,
        paymentDueDate: null,
        paymentMethod: null,
        products: uiBill.products
            .map((e) => PurchaseBillProductItem(
                price: e.price, productId: e.productId, quantity: e.quantity))
            .toList(),
        storeId: 1,
        supplierId: supplierId,
        supplierSequenceNumber: supplierSequenceNumber);
    final myvalue = billRequest.toJson();
    debug(myvalue);
    if (uiBill.id == null) {
      _addBill(uiBill, billRequest);
    } else {
      _updateBill(uiBill, billRequest);
    }
  }

  Future<void> _updateBill(
      UiPurchaseBillDetails uiBill, PurchaseBillRequest billRequest) async {
    final result = await _repo.updateBills(uiBill.id!, billRequest);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
    },
        (data) => _viewState.add(
            _viewState.value.navigateTo(PurchaseBillDetailsNavigation.back)));
  }

  Future<void> _addBill(
      UiPurchaseBillDetails uiBill, PurchaseBillRequest billRequest) async {
    final result = await _repo.addBill(billRequest);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
    },
        (data) => _viewState.add(
            _viewState.value.navigateTo(PurchaseBillDetailsNavigation.back)));
  }

  @override
  void dispose() {
    super.dispose();
    _viewState.close();
  }
}
