import 'package:flutter/cupertino.dart';
import 'package:car_part/common/extention/widget_ext.dart';

Row textWithLabel(String label, String data, MainAxisAlignment alignment) =>
    Row(
      children: [Text(label).addPadding(16.0), Text(data).addPadding(16.0)],
      mainAxisAlignment: alignment,
    );
