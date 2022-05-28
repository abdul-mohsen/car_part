import 'package:flutter/material.dart';
import 'package:car_part/common/extention/any_extension.dart';

typedef OnEvent = void Function(int index);

class TableView<T> extends DataTableSource {
  TableView({required this.items, this.onEevnt, required this.viewHolder});

  final List<T> items;
  final OnEvent? onEevnt;
  final List<DataCell> Function(T) viewHolder;

  @override
  DataRow? getRow(int index) {
    if (index >= items.length) {
      return null;
    }
    final _item = items[index];

    void onLongPress() => onEevnt?.let((fun) => fun(index));

    return DataRow.byIndex(
        index: index, cells: viewHolder(_item), onLongPress: onLongPress);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.

    The [compare] function must act as a [Comparator].

    List<String> numbers = ['two', 'three', 'four'];
// Sort from shortest to longest.
    numbers.sort((a, b) => a.length.compareTo(b.length));
    print(numbers);  // [two, four, three]
    The default List implementations use [Comparable.compare] if [compare] is omitted.

    List<int> nums = [13, 2, -11];
    nums.sort();
    print(nums);  // [-11, 2, 13] 
   */
  void sort(Comparable<T> Function(T d) getField, bool ascending) {
    items.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
