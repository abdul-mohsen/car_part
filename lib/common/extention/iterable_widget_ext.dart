import 'package:flutter/cupertino.dart';

extension IterableWidgetExt on Iterable<Widget> {
  Wrap addWrap(
          {Key? key,
          Axis direction = Axis.horizontal,
          WrapAlignment alignment = WrapAlignment.start,
          double spacing = 0.0,
          WrapAlignment runAlignment = WrapAlignment.start,
          double runSpacing = 0.0,
          WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
          TextDirection? textDirection,
          VerticalDirection verticalDirection = VerticalDirection.down,
          Clip clipBehavior = Clip.none,
          List<Widget> children = const <Widget>[]}) =>
      Wrap(children: toList());
}
