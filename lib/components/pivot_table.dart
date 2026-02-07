import 'package:flutter/material.dart';

// 数据透视表数据模型
class PivotDataItem {
  final String category;
  final String subCategory;
  final String product;
  final double value;

  PivotDataItem({
    required this.category,
    required this.subCategory,
    required this.product,
    required this.value,
  });
}

// 汇总结果模型
class PivotSummary {
  final String rowKey;
  final String columnKey;
  final double value;

  PivotSummary({
    required this.rowKey,
    required this.columnKey,
    required this.value,
  });
}

// 数据透视表组件
class PivotTableComponent extends StatefulWidget {
  const PivotTableComponent({super.key});

  @override
  State<PivotTableComponent> createState() => _PivotTableComponentState();
}

class _PivotTableComponentState extends State<PivotTableComponent> {
  // 示例数据
  final List<PivotDataItem> _data = [
    PivotDataItem(category: '电子产品', subCategory: '手机', product: 'iPhone', value: 5000),
    PivotDataItem(category: '电子产品', subCategory: '手机', product: 'Samsung', value: 4500),
    PivotDataItem(category: '电子产品', subCategory: '电脑', product: 'MacBook', value: 8000),
    PivotDataItem(category: '电子产品', subCategory: '电脑', product: 'Dell', value: 6000),
    PivotDataItem(category: '家居用品', subCategory: '家具', product: '沙发', value: 3000),
    PivotDataItem(category: '家居用品', subCategory: '家具', product: '桌子', value: 1500),
    PivotDataItem(category: '家居用品', subCategory: '电器', product: '冰箱', value: 4000),
    PivotDataItem(category: '家居用品', subCategory: '电器', product: '洗衣机', value: 3500),
    PivotDataItem(category: '服装', subCategory: '上衣', product: 'T恤', value: 200),
    PivotDataItem(category: '服装', subCategory: '上衣', product: '衬衫', value: 500),
    PivotDataItem(category: '服装', subCategory: '裤子', product: '牛仔裤', value: 800),
    PivotDataItem(category: '服装', subCategory: '裤子', product: '休闲裤', value: 600),
  ];

  // 汇总方式
  String _summaryType = 'sum'; // sum, avg, count

  // 选中的单元格
  PivotSummary? _selectedCell;

  // 计算汇总数据
  List<PivotSummary> _calculateSummary() {
    final summary = <PivotSummary>[];
    final categories = _data.map((item) => item.category).toSet().toList();
    final subCategories = _data.map((item) => item.subCategory).toSet().toList();

    for (final category in categories) {
      for (final subCategory in subCategories) {
        final items = _data.where((item) => item.category == category && item.subCategory == subCategory).toList();
        if (items.isNotEmpty) {
          double value;
          switch (_summaryType) {
            case 'sum':
              value = items.fold(0.0, (sum, item) => sum + item.value);
              break;
            case 'avg':
              value = items.fold(0.0, (sum, item) => sum + item.value) / items.length;
              break;
            case 'count':
              value = items.length.toDouble();
              break;
            default:
              value = 0.0;
          }
          summary.add(PivotSummary(
            rowKey: category,
            columnKey: subCategory,
            value: value,
          ));
        }
      }
    }

    return summary;
  }

  // 获取所有行和列的唯一值
  List<String> _getRowKeys() {
    return _data.map((item) => item.category).toSet().toList();
  }

  List<String> _getColKeys() {
    return _data.map((item) => item.subCategory).toSet().toList();
  }

  // 获取单元格值
  double _getCellValue(String rowKey, String colKey) {
    final summary = _calculateSummary();
    final cell = summary.firstWhere(
      (item) => item.rowKey == rowKey && item.columnKey == colKey,
      orElse: () => PivotSummary(rowKey: rowKey, columnKey: colKey, value: 0.0),
    );
    return cell.value;
  }

  // 处理单元格点击
  void _handleCellTap(String rowKey, String colKey) {
    final value = _getCellValue(rowKey, colKey);
    setState(() {
      _selectedCell = PivotSummary(
        rowKey: rowKey,
        columnKey: colKey,
        value: value,
      );
    });
  }

  // 切换汇总方式
  void _changeSummaryType(String type) {
    setState(() {
      _summaryType = type;
      _selectedCell = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rowKeys = _getRowKeys();
    final colKeys = _getColKeys();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(51),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 标题
          const Text(
            '数据透视表',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 说明文字
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '数据透视表用于汇总和分析数据，可通过不同维度查看数据分布情况。点击单元格可查看详细信息。',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // 汇总方式选择
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('汇总方式: '),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _summaryType,
                onChanged: (value) {
                  if (value != null) {
                    _changeSummaryType(value);
                  }
                },
                items: [
                  DropdownMenuItem(value: 'sum', child: const Text('求和')),
                  DropdownMenuItem(value: 'avg', child: const Text('平均值')),
                  DropdownMenuItem(value: 'count', child: const Text('计数')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 数据透视表
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: 400),
              child: DataTable(
                columns: [
                  DataColumn(label: Container(width: 80, child: const Text('类别'))),
                  ...colKeys.map((colKey) => DataColumn(label: Container(width: 100, child: Text(colKey, overflow: TextOverflow.ellipsis)))),
                ],
                rows: rowKeys.map((rowKey) {
                  return DataRow(
                    cells: [
                      DataCell(Container(width: 80, child: Text(rowKey, overflow: TextOverflow.ellipsis))),
                      ...colKeys.map((colKey) {
                        final value = _getCellValue(rowKey, colKey);
                        return DataCell(
                          Container(
                            width: 100,
                            child: GestureDetector(
                              onTap: () => _handleCellTap(rowKey, colKey),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _selectedCell != null &&
                                          _selectedCell!.rowKey == rowKey &&
                                          _selectedCell!.columnKey == colKey
                                      ? Colors.deepPurple.withAlpha(30)
                                      : Colors.grey.withAlpha(10),
                                  borderRadius: BorderRadius.circular(4),
                                  border: _selectedCell != null &&
                                          _selectedCell!.rowKey == rowKey &&
                                          _selectedCell!.columnKey == colKey
                                      ? Border.all(color: Colors.deepPurple, width: 1)
                                      : null,
                                ),
                                child: Text(
                                  _summaryType == 'count'
                                      ? value.toInt().toString()
                                      : value.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: _selectedCell != null &&
                                            _selectedCell!.rowKey == rowKey &&
                                            _selectedCell!.columnKey == colKey
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 选中信息
          if (_selectedCell != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '选中单元格信息',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('类别: ${_selectedCell!.rowKey}'),
                  Text('子类别: ${_selectedCell!.columnKey}'),
                  Text('${_summaryType == 'sum' ? '求和' : _summaryType == 'avg' ? '平均值' : '计数'}: ${_summaryType == 'count' ? _selectedCell!.value.toInt().toString() : _selectedCell!.value.toStringAsFixed(2)}'),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedCell = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('重置选中'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
