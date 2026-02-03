import 'package:flutter/material.dart';

// 表格数据模型
class TableRowData {
  final List<dynamic> cells; // 行数据

  TableRowData({required this.cells});
}

// 表格配置模型
class TableConfig {
  final List<String> headers; // 表头
  final List<TableRowData> rows; // 表格数据
  final List<double>? columnWidths; // 列宽
  final TextStyle? headerStyle; // 表头样式
  final TextStyle? rowStyle; // 行样式
  final Color? headerColor; // 表头背景色
  final Color? rowColor; // 行背景色
  final Color? alternateRowColor; // 交替行背景色
  final double cellPadding; // 单元格内边距
  final double borderWidth; // 边框宽度
  final Color borderColor; // 边框颜色

  TableConfig({
    required this.headers,
    required this.rows,
    this.columnWidths,
    this.headerStyle,
    this.rowStyle,
    this.headerColor,
    this.rowColor,
    this.alternateRowColor,
    this.cellPadding = 12.0,
    this.borderWidth = 1.0,
    this.borderColor = Colors.grey,
  });
}

// 表格组件
class TableWidget extends StatelessWidget {
  final TableConfig config; // 表格配置

  const TableWidget({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: config.borderColor,
            width: config.borderWidth,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 表头
            _buildHeaderRow(),
            // 表格数据
            ..._buildDataRows(),
          ],
        ),
      ),
    );
  }

  // 构建表头行
  Widget _buildHeaderRow() {
    return Container(
      color: config.headerColor ?? Colors.blue.shade50,
      child: Row(
        children: List.generate(config.headers.length, (index) {
          return Container(
            width: config.columnWidths != null && index < config.columnWidths!.length
                ? config.columnWidths![index]
                : 120,
            padding: EdgeInsets.all(config.cellPadding),
            decoration: BoxDecoration(
              border: Border(
                right: index < config.headers.length - 1
                    ? BorderSide(color: config.borderColor, width: config.borderWidth)
                    : BorderSide.none,
                bottom: BorderSide(color: config.borderColor, width: config.borderWidth),
              ),
            ),
            child: Text(
              config.headers[index],
              style: config.headerStyle ??
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
            ),
          );
        }),
      ),
    );
  }

  // 构建数据行
  List<Widget> _buildDataRows() {
    return List.generate(config.rows.length, (rowIndex) {
      final row = config.rows[rowIndex];
      final isAlternate = rowIndex % 2 == 1;
      
      return Container(
        color: isAlternate && config.alternateRowColor != null
            ? config.alternateRowColor
            : config.rowColor ?? Colors.white,
        child: Row(
          children: List.generate(row.cells.length, (cellIndex) {
            return Container(
              width: config.columnWidths != null && cellIndex < config.columnWidths!.length
                  ? config.columnWidths![cellIndex]
                  : 120,
              padding: EdgeInsets.all(config.cellPadding),
              decoration: BoxDecoration(
                border: Border(
                  right: cellIndex < row.cells.length - 1
                      ? BorderSide(color: config.borderColor, width: config.borderWidth)
                      : BorderSide.none,
                  bottom: rowIndex < config.rows.length - 1
                      ? BorderSide(color: config.borderColor, width: config.borderWidth)
                      : BorderSide.none,
                ),
              ),
              child: Text(
                row.cells[cellIndex].toString(),
                style: config.rowStyle ??
                    TextStyle(
                      color: Colors.grey.shade800,
                    ),
              ),
            );
          }),
        ),
      );
    });
  }
}

// 获取示例表格数据
TableConfig getExampleTableConfig() {
  return TableConfig(
    headers: ['姓名', '年龄', '性别', '职业', '城市'],
    rows: [
      TableRowData(cells: ['张三', 28, '男', '工程师', '北京']),
      TableRowData(cells: ['李四', 32, '女', '设计师', '上海']),
      TableRowData(cells: ['王五', 25, '男', '产品经理', '广州']),
      TableRowData(cells: ['赵六', 30, '女', '运营', '深圳']),
      TableRowData(cells: ['钱七', 35, '男', '销售', '杭州']),
      TableRowData(cells: ['孙八', 29, '女', '教师', '南京']),
    ],
    columnWidths: [100, 80, 80, 120, 100],
    headerColor: Colors.blue.shade100,
    alternateRowColor: Colors.grey.shade50,
  );
}