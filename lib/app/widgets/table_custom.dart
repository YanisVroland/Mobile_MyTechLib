import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/color_const.dart';

class CustomTable extends StatefulWidget {
  String textListEmpty;
  List<dynamic> listObj;
  List<DataRow> dataRows;
  List<DataRow> dataFixedRows;
  List<String> listTitleColumn;

  CustomTable({
    required this.textListEmpty,
    required this.listTitleColumn,
    required this.listObj,
    required this.dataRows,
    required this.dataFixedRows,
  }) : super();

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  late List<DataColumn> dataColumns;

  DataColumn dataColumnCustom(String test, {Color color = Colors.black}) {
    return DataColumn(
        label: Expanded(
            child: Center(
                child: Text(test, textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)))));
  }

  Widget fixedRow() => SizedBox(
      width: double.infinity,
      child: Material(
        color: ColorConst.primary,
        child: DataTable(
          columns: dataColumns,
          rows: widget.dataFixedRows,
          dataRowHeight: 0,
        ),
      ));

  List<DataColumn> createDataColumns() {
    List<DataColumn> dataColumns = [];
    for (String columnName in widget.listTitleColumn) {
      dataColumns.add(dataColumnCustom(columnName, color: Colors.black));
    }
    return dataColumns;
  }

  @override
  void initState() {
    dataColumns = createDataColumns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.black, width: 0.5),
        )),
        child: Stack(children: <Widget>[
          widget.listObj.isNotEmpty
              ? SingleChildScrollView(
                  child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                          dataRowHeight: 60,
                          columns: dataColumns,
                          rows: widget.dataRows )))
              : Center(child: Text(widget.textListEmpty)),
          fixedRow(),
        ]));
  }
}
