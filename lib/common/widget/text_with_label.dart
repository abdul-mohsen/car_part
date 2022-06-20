import 'package:flutter/cupertino.dart';
import 'package:car_part/common/extention/widget_ext.dart';

Row textWithLabel(String label, String data, MainAxisAlignment alignment) =>
    Row(
      mainAxisAlignment: alignment,
      children: [Text(label).addPadding(16.0), Text(data).addPadding(16.0)],
    );
