import 'package:flutter/cupertino.dart';

extension NullableStringExtention on Widget {
  Padding addPadding(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);
}
