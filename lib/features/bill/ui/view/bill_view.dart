import 'package:car_part/common/extention/any_extension.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/common/widget/list_adapter.dart';
import 'package:car_part/features/bill/ui/view/bill_view_model.dart';
import 'package:car_part/features/bill/ui/view/model/bill_view_state.dart';
import 'package:car_part/features/bill/ui/view/model/ui_bill_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BillView extends View<BillViewModel> {
  const BillView({required BillViewModel viewModel, Key? key})
      : super.model(viewModel, key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ViewState<BillView, BillViewModel> {
  _LoginState() : super(Modular.get<BillViewModel>());
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    viewModel.viewState.listen((event) {
      event.loading.getContentIfNotHandled()?.let((it) {
        showLoading(it);
      });

      event.navigate.getContentIfNotHandled()?.let((navigation) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BillViewState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) => Scaffold(
              appBar: AppBar(title: const Text("bills")),
              body: getListAdapter<UiBillView>(
                  snapshot.data?.uiBills ?? [], controller, getCard),
            ));
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      viewModel.loadBills();
    }
  }

  Widget getCard(UiBillView item) => Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(child: Text(item.id.toString())),
          title: Text(item.subTotal.toString()),
        ),
      ));
}
