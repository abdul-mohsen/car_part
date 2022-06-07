import 'package:flutter/cupertino.dart';

extension NullableStringExtention on Widget {
  Padding addPadding(double value) =>
      Padding(child: this, padding: EdgeInsets.all(value));
}
