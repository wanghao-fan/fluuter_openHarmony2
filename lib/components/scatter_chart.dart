import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// 散点图数据模型
class ScatterChartDataModel {
  final String title;
  final List<ScatterSpot> spots;
  final Color color;
  final double radius;

  ScatterChartDataModel({
    required this.title,
    required this.spots,
    required this.color,
    required this.radius,
  });
}

/// 自定义散点图组件
class CustomScatterChart extends StatelessWidget {
  final String title;
  final List<ScatterChartDataModel> data;
  final Function(ScatterSpot, ScatterChartDataModel)? onPointTap;

  const CustomScatterChart({
    super.key,
    required this.title,
    required this.data,
    this.onPointTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // 图表区域
          Expanded(
            child: ScatterChartWidget(
              data: data,
              onPointTap: onPointTap,
            ),
          ),

          const SizedBox(height: 16),

          // 图例
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final dataset = data[index];
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dataset.color,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(dataset.title),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 散点图核心组件
class ScatterChartWidget extends StatefulWidget {
  final List<ScatterChartDataModel> data;
  final Function(ScatterSpot, ScatterChartDataModel)? onPointTap;

  const ScatterChartWidget({
    super.key,
    required this.data,
    this.onPointTap,
  });

  @override
  _ScatterChartWidgetState createState() => _ScatterChartWidgetState();
}

class _ScatterChartWidgetState extends State<ScatterChartWidget> {
  List<ScatterSpot> _allSpots = [];

  @override
  void initState() {
    super.initState();
    _initializeSpots();
  }

  void _initializeSpots() {
    _allSpots = [];
    for (var dataset in widget.data) {
      _allSpots.addAll(dataset.spots);
    }
  }

  @override
  void didUpdateWidget(covariant ScatterChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _initializeSpots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScatterChart(
      ScatterChartData(
        scatterSpots: _allSpots,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withAlpha(100),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withAlpha(100),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey.withAlpha(200),
            width: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 10,
        scatterTouchData: ScatterTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: ScatterTouchTooltipData(
            getTooltipItems: null,
          ),
          touchCallback: (FlTouchEvent event, ScatterTouchResponse? response) {
            if (event is PointerDownEvent && response != null) {
              final touchedSpot = response.touchedSpot;
              if (touchedSpot != null) {
                // 找到对应的数据集
                for (var dataset in widget.data) {
                  // 检查是否有匹配的散点
                  for (var spot in dataset.spots) {
                    if (spot.x == touchedSpot.spot.x && spot.y == touchedSpot.spot.y) {
                      widget.onPointTap?.call(spot, dataset);
                      break;
                    }
                  }
                }
              }
            }
          },
        ),
      ),
    );
  }
}