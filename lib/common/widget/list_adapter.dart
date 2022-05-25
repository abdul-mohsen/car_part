import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ListView getListAdapter<T>(List<T> items, ScrollController controller,
        Widget Function(T) render) =>
    ListView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return render(items[index]);
      },
    );
