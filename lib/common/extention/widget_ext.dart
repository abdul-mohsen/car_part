import 'package:flutter/cupertino.dart';

extension WigetExt on Widget {
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

  Container addContainer({
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Clip clipBehavior = Clip.none,
  }) =>
      Container(
        key: key,
        color: color,
        child: this,
      );

  SizedBox addSizedBox({double? width}) => SizedBox(width: width, child: this);

  Align addAlign({
    Key? key,
    AlignmentGeometry alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) =>
      Align(
        key: key,
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );
}
