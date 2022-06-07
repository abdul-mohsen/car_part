import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/common/widget/custom_scaffold.dart';
import 'package:car_part/common/widget/edit_text.dart';
import 'package:car_part/common/widget/text_with_label.dart';
import 'package:car_part/features/bill/data/domain/model/bill_product.dart';
import 'package:car_part/features/bill/ui/details/bill_details_view_model.dart';
import 'package:car_part/features/bill/ui/details/model/bill_details_navigation.dart';
import 'package:car_part/features/bill/ui/details/model/bill_details_view_state.dart';
import 'package:car_part/features/bill/ui/details/model/ui_details_view.dart';
import 'package:car_part/features/carPart/data/repository/model/car_part_auto_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/widget_ext.dart';

class BillDetailsView extends View {
  const BillDetailsView({Key? key}) : super.model(key: key);

  @override
  _BillDetailsViewState createState() => _BillDetailsViewState();
}

class _BillDetailsViewState
    extends ViewState<BillDetailsView, BillDetailsViewModel> {
  _BillDetailsViewState() : super(Modular.get<BillDetailsViewModel>());

  @override
  void initState() {
    super.initState();
    // viewModel.loadBill(id);

    viewModel.viewState.listen((event) {
      event.loading.getContentIfNotHandled()?.let((it) {
        showLoading(it);
      });

      event.navigate.getContentIfNotHandled()?.let((navigation) {
        switch (navigation) {
          case BillDetailsNavigation.addProducts:
            {
              // Modular.to.pushNamed("/addProduct");
              showDialog(context: context, builder: (_) => _createDialog());
              break;
            }
          case BillDetailsNavigation.back:
            {
              Modular.to.pop();
              break;
            }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BillDetailsViewState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) => CustomScaffold(
            enableDarkMode: true,
            titleText: "bill details",
            child: snapshot.data?.uiBill?.runAndReturn((e) => getCard(e)) ??
                const Text("")));
  }

  Widget getCard(UiBillDetails item) => Card(
          child: Column(
        children: bindItem(item),
      ).addPadding(8.0));

  List<Widget> bindItem(UiBillDetails item) => [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: getEditText(
                    label: "UserName",
                    text: item.userName,
                    width: 250,
                    onTextChange: (text) => viewModel.onUserNameChange(text))),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: getEditText(
                    label: "UserPhone",
                    text: item.userPhoneNumber,
                    width: 250,
                    onTextChange: (text) =>
                        viewModel.onPhoneNumberChange(text)))
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Flexible(
            child: getEditText(
                label: "notes",
                text: item.userPhoneNumber,
                width: 700,
                maxLines: null,
                onTextChange: (text) => viewModel.onNoteChange(text))),
        DataTable(
          rows: item.products.map((e) => _viewHolder(e)).toList(),
          sortColumnIndex: 0,
          columns: _header
              .map((e) => DataColumn(label: Expanded(child: e)))
              .toList(),
        ),
        IconButton(
          onPressed: viewModel.toAddProductsView,
          icon: const Icon(Icons.add),
        ).addPadding(16),
        textWithLabel("maintenace const",
            item.maintenanceCost.toStringAsFixed(2), MainAxisAlignment.center),
        textWithLabel("subTotal", item.subTotal.toStringAsFixed(2),
            MainAxisAlignment.center),
        textWithLabel("discount", item.discount.toStringAsFixed(2),
            MainAxisAlignment.center),
        textWithLabel(
            "vat", item.vat.toStringAsFixed(2), MainAxisAlignment.center),
        textWithLabel(
            "total",
            (item.vat + item.maintenanceCost + item.subTotal - item.discount)
                .toStringAsFixed(2),
            MainAxisAlignment.center),
        Row(
          children: [
            ElevatedButton(
                    onPressed: viewModel.navigateBack,
                    child: const Text("cancel"))
                .addPadding(16),
            ElevatedButton(
                    onPressed: viewModel.saveData, child: const Text("save"))
                .addPadding(16),
            ElevatedButton(
                    onPressed: viewModel.confirmData,
                    child: const Text("confirm"))
                .addPadding(16),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ];

  DataRow _viewHolder(BillProduct product) => DataRow(
      cells:
          _bindItem(product).map((e) => DataCell(Center(child: e))).toList());

  List<Widget> _bindItem(BillProduct item) => [
        Text(item.partName),
        Text(item.partNumber),
        getEditText(
            text: item.price.toStringAsFixed(2),
            onTextChange: (text) =>
                viewModel.onPriceChange(item.productId, text),
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r'(^\d*\.?\d{0,2})'),
                  allow: true)
            ]),
        getEditText(
          text: item.quantity.toString(),
          onTextChange: (text) =>
              viewModel.onQuantityChange(item.productId, text),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => viewModel.onDeleteProdcut(item.productId),
        )
      ];

  final _header = [
    Text("part name", textAlign: TextAlign.center),
    Text("part number", textAlign: TextAlign.center),
    Text("price", textAlign: TextAlign.center),
    Text("quantity", textAlign: TextAlign.center),
    Text("", textAlign: TextAlign.center),
  ];

  Widget _createDialog() => AlertDialog(
        title: const Text("Product"),
        actions: const [
          TextButton(
            onPressed: null,
            child: Text("cancel"),
          ),
          TextButton(onPressed: null, child: Text("ok"))
        ],
        content: Autocomplete<CarPartAutoComplete>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text == '') {
            return [];
          }
          final result =
              await viewModel.autoCompleteList(textEditingValue.text);
          return result.data ?? [];
        }, onSelected: (CarPartAutoComplete selection) {
          viewModel.onSelecteProduct(selection);
          debugPrint('You just selected $selection');
        }),
      );
}
