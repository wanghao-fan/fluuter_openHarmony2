import 'package:flutter/material.dart';
import 'dart:math';
import '../services/data_service.dart';

class KLineChartComponent extends StatelessWidget {
  final List<KLineData> data;
  final String title;
  final Color risingColor;
  final Color fallingColor;
  final Color backgroundColor;
  final bool showGrid;

  const KLineChartComponent({
    Key? key,
    required this.data,
    this.title = '实时K线图',
    this.risingColor = Colors.red,
    this.fallingColor = Colors.green,
    this.backgroundColor = Colors.white,
    this.showGrid = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: KLineChartPainter(data: data, risingColor: risingColor, fallingColor: fallingColor, showGrid: showGrid),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '数据点: ${data.length}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              if (data.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '最新: ${data.last.close.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: data.last.close >= data.last.open ? risingColor : fallingColor,
                      ),
                    ),
                    Text(
                      '最高: ${data.last.high.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      '最低: ${data.last.low.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}



// K线图画布
class KLineChartPainter extends StatelessWidget {
  final List<KLineData> data;
  final Color risingColor;
  final Color fallingColor;
  final bool showGrid;

  const KLineChartPainter({
    Key? key,
    required this.data,
    required this.risingColor,
    required this.fallingColor,
    required this.showGrid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _KLinePainter(
        data: data,
        risingColor: risingColor,
        fallingColor: fallingColor,
        showGrid: showGrid,
      ),
    );
  }
}

// K线图绘制器
class _KLinePainter extends CustomPainter {
  final List<KLineData> data;
  final Color risingColor;
  final Color fallingColor;
  final bool showGrid;

  _KLinePainter({
    required this.data,
    required this.risingColor,
    required this.fallingColor,
    required this.showGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    // 计算数据范围
    double minPrice = data.map((d) => d.low).reduce((a, b) => a < b ? a : b);
    double maxPrice = data.map((d) => d.high).reduce((a, b) => a > b ? a : b);
    double priceRange = maxPrice - minPrice;

    // 计算绘制区域
    double padding = 20;
    double chartWidth = size.width - padding * 2;
    double chartHeight = size.height - padding * 2;

    // 绘制网格
    if (showGrid) {
      _drawGrid(canvas, size, padding, chartWidth, chartHeight);
    }

    // 绘制K线
    double candleWidth = chartWidth / data.length * 0.6;
    double candleSpacing = chartWidth / data.length * 0.4;

    for (int i = 0; i < data.length; i++) {
      KLineData kLine = data[i];
      double x = padding + i * (candleWidth + candleSpacing) + candleSpacing / 2;

      // 计算价格对应的Y坐标
      double openY = padding + chartHeight - (kLine.open - minPrice) / priceRange * chartHeight;
      double closeY = padding + chartHeight - (kLine.close - minPrice) / priceRange * chartHeight;
      double highY = padding + chartHeight - (kLine.high - minPrice) / priceRange * chartHeight;
      double lowY = padding + chartHeight - (kLine.low - minPrice) / priceRange * chartHeight;

      // 绘制K线
      _drawCandle(canvas, x, openY, closeY, highY, lowY, candleWidth, kLine);
    }
  }

  // 绘制网格
  void _drawGrid(Canvas canvas, Size size, double padding, double chartWidth, double chartHeight) {
    Paint gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // 绘制垂直线
    for (int i = 0; i <= 5; i++) {
      double x = padding + chartWidth / 5 * i;
      canvas.drawLine(Offset(x, padding), Offset(x, size.height - padding), gridPaint);
    }

    // 绘制水平线
    for (int i = 0; i <= 5; i++) {
      double y = padding + chartHeight / 5 * i;
      canvas.drawLine(Offset(padding, y), Offset(size.width - padding, y), gridPaint);
    }
  }

  // 绘制K线
  void _drawCandle(Canvas canvas, double x, double openY, double closeY, double highY, double lowY, double candleWidth, KLineData kLine) {
    bool isRising = kLine.close >= kLine.open;
    Color candleColor = isRising ? risingColor : fallingColor;

    // 绘制影线
    Paint linePaint = Paint()
      ..color = candleColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(x, highY), Offset(x, lowY), linePaint);

    // 绘制实体
    Paint rectPaint = Paint()
      ..color = candleColor
      ..style = PaintingStyle.fill;

    double rectTop = openY < closeY ? openY : closeY;
    double rectHeight = closeY > openY ? closeY - openY : openY - closeY;

    if (rectHeight < 1) rectHeight = 1;

    Rect candleRect = Rect.fromLTWH(
      x - candleWidth / 2,
      rectTop,
      candleWidth,
      rectHeight,
    );

    canvas.drawRect(candleRect, rectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
