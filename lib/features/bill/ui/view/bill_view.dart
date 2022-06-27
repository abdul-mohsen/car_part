import 'dart:async';

import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/features/bill/ui/view/bill_view_model.dart';
import 'package:car_part/features/bill/ui/view/model/bill_navigation.dart';
import 'package:car_part/features/bill/ui/view/model/bill_view_state.dart';
import 'package:car_part/features/bill/ui/view/model/ui_bill_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/widget_ext.dart';
import 'package:car_part/common/extention/resource_ext.dart';

class BillView extends View {
  const BillView({Key? key}) : super.model(key: key);

  @override
  BillState createState() => BillState();
}

class BillState extends ViewState<BillView, BillViewModel> {
  BillState() : super(Modular.get<BillViewModel>());
  ScrollController controller = ScrollController();
  late StreamSubscription<BillViewState> stream;

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
          case BillViewNavigation.billDetails:
            {
              Modular.to.pushNamed("/bill_details",
                  arguments: event.targerBillId.getContentIfNotHandled());
              break;
            }
          case BillViewNavigation.back:
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BillViewState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) => SingleChildScrollView(
              controller: controller,
              child: DataTable(
                rows: (snapshot.data?.uiBills ?? [])
                    .map((e) => _viewHolder(e))
                    .toList(),
                sortColumnIndex: 0,
                columns: _getHeader(context)
                    .map((e) => DataColumn(label: Expanded(child: e)))
                    .toList(),
              ).addContainer(),
            ));
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      viewModel.loadBills();
    }
  }

  DataRow _viewHolder(UiBillView item) => DataRow(
      cells: _bindItem(item).map((e) => DataCell(Center(child: e))).toList(),
      onLongPress: () => viewModel.navigateToDetails(item.id));

  List<Widget> _bindItem(UiBillView item) => [
        Text(item.id.toString()),
        Text(item.userName),
        Text(item.userPhoneNumber),
        Text(item.maintenanceCost.toString()),
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

  List<Widget> _getHeader(BuildContext context) => [
        Text("id", textAlign: TextAlign.center),
        Text("customer", textAlign: TextAlign.center),
        Text(context.getStrings().mobileNumber, textAlign: TextAlign.center),
        Text("maintenance cost", textAlign: TextAlign.center),
        Text("subTotal", textAlign: TextAlign.center),
        Text("discount", textAlign: TextAlign.center),
        Text("vat", textAlign: TextAlign.center),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: viewModel.createNewBill,
        ),
      ];
}
