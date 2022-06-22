import 'package:car_part/common/ui/view.dart';
import 'package:car_part/common/widget/custom_scaffold.dart';
import 'package:car_part/features/bill/ui/view/model/bill_view_state.dart';
import 'package:car_part/features/purchase_bill/ui/view/purchase_bill_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/widget_ext.dart';

class PurchaseBillView extends View {
  const PurchaseBillView({Key? key}) : super.model(key: key);

  @override
  PurchaseBillState createState() => PurchaseBillState();
}

class PurchaseBillState
    extends ViewState<PurchaseBillView, PurchaseBillViewModel> {
  PurchaseBillState() : super(Modular.get<PurchaseBillViewModel>());
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BillViewState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) => SingleChildScrollView(
              controller: controller,
              child: const Text("sdfasdfa").addCenter().addContainer(),
            ));
  }
}
