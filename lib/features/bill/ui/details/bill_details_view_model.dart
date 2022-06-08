import 'package:car_part/common/domain/result.dart';
import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/ui/view_model.dart';
import 'package:car_part/features/bill/data/domain/model/bill_details.dart';
import 'package:car_part/features/bill/data/domain/model/bill_product.dart';
import 'package:car_part/features/bill/data/domain/repository/bill_repository_abs.dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/bill_request.dart';
import 'package:car_part/features/bill/data/remote/model/request/bill_request/product_request.dart';
import 'package:car_part/features/bill/ui/details/model/bill_details_navigation.dart';
import 'package:car_part/features/bill/ui/details/model/bill_details_view_state.dart';
import 'package:car_part/features/bill/ui/details/model/ui_details_view.dart';
import 'package:car_part/features/carPart/data/repository/car_part_repository_abs.dart';
import 'package:car_part/features/carPart/data/repository/model/car_part_auto_complete.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class BillDetailsViewModel extends ViewModel {
  final _viewState = BehaviorSubject<BillDetailsViewState>.seeded(
      BillDetailsViewState.initViewState());
  Stream<BillDetailsViewState> get viewState => _viewState;

  final _repo = Modular.get<IBillRepository>();
  final _carPartAutoCompleteRepo = Modular.get<ICarPartRepository>();
  String? userName;
  String? phoneNumber;
  String? note;

  @override
  void init() {
    super.init();
    loadBill();
  }

  void onUserNameChange(String? text) {
    userName = text;
  }

  void onPhoneNumberChange(String? text) {
    phoneNumber = text;
  }

  void onNoteChange(String? text) {
    note = text;
  }

  void loadBill() async {
    int? id = Modular.args.data;
    if (id == null) {
      _viewState.add(_viewState.value.updateBillDetails(UiBillDetails(
          id: null,
          effectiveDate: "-",
          paymentDueDate: "-",
          state: 1,
          subTotal: 0,
          discount: 0,
          vat: 0,
          sequenceNumber: "",
          maintenanceCost: 0,
          note: "",
          userName: "",
          userPhoneNumber: "",
          products: [])));
      return;
    }
    _viewState.add(_viewState.value.updateLoading());
    final result = await _repo.getBillDetails(id);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
      return error;
    },
        (data) => _viewState
            .add(_viewState.value.updateBillDetails(_fromDomain(data))));
  }

  UiBillDetails _fromDomain(BillDetails bill) => UiBillDetails(
      id: bill.id,
      effectiveDate: bill.effectiveDate ?? "-",
      paymentDueDate: bill.paymentDueDate ?? "-",
      discount: bill.discount ?? 0.0,
      maintenanceCost: bill.maintenanceCost ?? 0.0,
      note: bill.note ?? "",
      subTotal: bill.subTotal ?? 0.0,
      vat: bill.vat,
      sequenceNumber: bill.sequenceNumber?.toString() ?? "",
      state: bill.state,
      userName: bill.userName ?? "",
      userPhoneNumber: bill.userPhoneNumber ?? "",
      products: bill.products);

  void toAddProductsView() {
    _viewState
        .add(_viewState.value.navigateTo(BillDetailsNavigation.addProducts));
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
    BillProduct product = BillProduct(
        productId: part.id,
        partName: "-",
        partNumber: part.oemNumber,
        price: 0.0,
        quantity: 1);
    _viewState.add(_viewState.value.onAddProdcut(product));
  }

  void navigateBack() {
    _viewState.add(_viewState.value.navigateTo(BillDetailsNavigation.back));
  }

  void saveData() {
    _submitData(userName, phoneNumber, note, 1);
  }

  void confirmData() {
    _submitData(userName, phoneNumber, note, 2);
  }

  void _submitData(
      String? userName, String? userPhone, String? note, int state) {
    final uiBill = _viewState.value.uiBill!;
    final billRequest = BillRequest(
      state: state,
      discount: uiBill.discount.toString(),
      maintenanceCost: uiBill.maintenanceCost.toString(),
      note: note,
      paidAmount: "0.0",
      paymentDate: null,
      paymentDueDate: null,
      paymentMethod: null,
      products: uiBill.products
          .map((e) => ProductRequest(
              price: e.price, productId: e.productId, quantity: e.quantity))
          .toList(),
      storeId: 1,
      userName: userName,
      userPhoneNumber: userPhone,
    );
    final myvalue = billRequest.toJson();
    debug(myvalue);
    if (uiBill.id == null) {
      _addBill(uiBill, billRequest);
    } else {
      _updateBill(uiBill, billRequest);
    }
  }

  Future<void> _updateBill(
      UiBillDetails uiBill, BillRequest billRequest) async {
    final result = await _repo.updateBills(uiBill.id!, billRequest);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
      return error;
    },
        (data) => _viewState
            .add(_viewState.value.navigateTo(BillDetailsNavigation.back)));
  }

  Future<void> _addBill(UiBillDetails uiBill, BillRequest billRequest) async {
    final result = await _repo.addBill(billRequest);
    result.when((error) {
      _viewState.add(_viewState.value.updateError(error));
      return error;
    },
        (data) => _viewState
            .add(_viewState.value.navigateTo(BillDetailsNavigation.back)));
  }

  @override
  void dispose() {
    super.dispose();
    _viewState.close();
  }
}
