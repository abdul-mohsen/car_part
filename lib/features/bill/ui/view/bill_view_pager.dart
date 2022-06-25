import 'package:car_part/app_buttom.dart';
import 'package:car_part/common/widget/custom_scaffold.dart';
import 'package:car_part/features/bill/ui/view/bill_view.dart';
import 'package:car_part/features/purchase_bill/ui/view/purchase_bill_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_part/common/extention/widget_ext.dart';

class BillPagerView extends StatelessWidget {
  const BillPagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return CustomScaffold(
        enableDarkMode: true,
        titleText: "bills",
        child: Column(
          children: [
            Row(
              children: [
                AppButton(
                    child: const Text("bills").addCenter().addPadding(16),
                    onTap: () => controller.jumpToPage(0)).addExpanded(),
                AppButton(
                    child:
                        const Text("purchase bills").addCenter().addPadding(16),
                    onTap: () => controller.jumpToPage(1)).addExpanded()
              ],
            ),
            PageView(
              /// [PageView.scrollDirection] defaults to [Axis.horizontal].
              /// Use [Axis.vertical] to scroll vertically.
              controller: controller,
              children: const <Widget>[BillView(), PurchaseBillView()],
            ).addExpanded()
          ],
        ));
  }
}
