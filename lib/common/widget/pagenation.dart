import 'package:flutter/material.dart';

typedef OnRowChange = void Function(int? index);

class CustomPaginatedTable extends StatelessWidget {
  const CustomPaginatedTable({
    Key? key,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
    required DataTableSource source,
    required List<DataColumn> columns,
    Widget? header,
    bool showActions = false,
    List<Widget>? actions,
    required this.sortColumnIndex,
    this.sortColumnAsc = true,
    this.onRowChanged,
  })  : _source = source,
        _dataColumns = columns,
        _header = header,
        _showActions = showActions,
        _actions = actions,
        super(key: key);

  /// This is the source / model which will be binded
  ///
  /// to each item in the Row...
  final DataTableSource _source;

  /// This is the list of columns which will be shown
  ///
  /// at the top of the DataTable.
  final List<DataColumn> _dataColumns;

  final Widget? _header;
  final bool _showActions;
  final List<Widget>? _actions;
  final int rowsPerPage;
  final int sortColumnIndex;
  final bool sortColumnAsc;

  final OnRowChange? onRowChanged;

  DataTableSource get _fetchDataTableSource => _source;

  List<DataColumn> get _fetchDataColumns => _dataColumns;

  Widget? get _fetchHeader => _header;

  List<Widget>? get _fetchActions => _showActions ? _actions : null;

  @override
  Widget build(BuildContext context) => Scrollbar(
        child: PaginatedDataTable(
          actions: _fetchActions,
          columns: _fetchDataColumns,
          header: _fetchHeader,
          onRowsPerPageChanged: onRowChanged,
          rowsPerPage: rowsPerPage,
          source: _fetchDataTableSource,
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortColumnAsc,
        ),
      );
}

class SampleSource extends DataTableSource {
  @override
  DataRow getRow(int index) {
    //

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('row #$index')),
        DataCell(Text('name #$index')),
      ],
    );
  }

  @override
  int get rowCount => 10;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
