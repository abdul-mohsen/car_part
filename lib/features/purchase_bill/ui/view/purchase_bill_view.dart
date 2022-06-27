import 'dart:async';

import 'package:car_part/common/ui/view.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/purchase_bill_view_navigation.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/purchase_bill_view_state.dart';
import 'package:car_part/features/purchase_bill/ui/view/model/ui_purchase_bill_view.dart';
import 'package:car_part/features/purchase_bill/ui/view/purchase_bill_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/widget_ext.dart';
import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/extention/resource_ext.dart';

class PurchaseBillView extends View {
  const PurchaseBillView({Key? key}) : super.model(key: key);

  @override
  PurchaseBillState createState() => PurchaseBillState();
}

class PurchaseBillState
    extends ViewState<PurchaseBillView, PurchaseBillViewModel> {
  PurchaseBillState() : super(Modular.get<PurchaseBillViewModel>());
  ScrollController controller = ScrollController();
  late StreamSubscription<PurchaseBillViewState> stream;

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);

    stream = viewModel.viewState.listen((event) {
      event.loading.getContentIfNotHandled()?.let((it) {
        showLoading(it);
      });

      event.navigate.getContentIfNotHandled()?.let((navigation) {
        switch (navigation) {
          case PurcahseBillViewNavigation.billDetails:
            {
              Modular.to.pushNamed("/purchase_bill_details",
                  arguments: event.targerBillId.getContentIfNotHandled());
              break;
            }
          case PurcahseBillViewNavigation.back:
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PurchaseBillViewState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) => SingleChildScrollView(
              controller: controller,
              child: DataTable(
                rows: (snapshot.data?.uiBills ?? [])
                    .map((e) => _viewHolder(e))
                    .toList(),
                sortColumnIndex: 0,
                columns: _getHeader()
                    .map((e) => DataColumn(label: Expanded(child: e)))
                    .toList(),
              ).addContainer(),
            ));
  }

  DataRow _viewHolder(UiPurchaseBillView item) => DataRow(
      cells: _bindItem(item).map((e) => DataCell(Center(child: e))).toList(),
      onLongPress: () => viewModel.navigateToDetails(item.id));

  List<Widget> _bindItem(UiPurchaseBillView item) => [
        Text(item.id.toString()),
        Text(item.supplierId),
        Text(item.supplierSequenceNumber),
        Text(item.subTotal.toString()),
        Text(item.discount.toString()),
        Text(item.vat.toString()),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            viewModel.deleteBill(item.id);
          },
        )
      ];

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      viewModel.loadBills();
    }
  }

  List<Widget> _getHeader() => [
        Text(context.getStrings().vendorId, textAlign: TextAlign.center),
        Text(context.getStrings().vendorNumber, textAlign: TextAlign.center),
        Text(context.getStrings().vendorNumber, textAlign: TextAlign.center),
        Text("subTotal", textAlign: TextAlign.center),
        Text("discount", textAlign: TextAlign.center),
        Text(context.getStrings().vendoreVatNumber,
            textAlign: TextAlign.center),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: viewModel.createNewBill,
        ),
      ];
}
