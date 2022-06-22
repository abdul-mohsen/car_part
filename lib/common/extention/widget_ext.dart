import 'package:flutter/cupertino.dart';

extension NullableStringExtention on Widget {
  Padding addPadding(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Center addCenter() => Center(child: this);

  ConstrainedBox addConstrainedBox(BoxConstraints constraints) =>
      ConstrainedBox(constraints: constraints, child: this);

  Expanded addExpanded() => Expanded(child: this);
  LimitedBox addLimitedBox(
          {double maxHeight = double.infinity,
          double maxWidth = double.infinity}) =>
      LimitedBox(maxHeight: maxHeight, maxWidth: maxWidth, child: this);

  Container addContainer() => Container(
        child: this,
      );
}
