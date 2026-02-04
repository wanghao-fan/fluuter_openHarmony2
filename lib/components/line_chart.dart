import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartDataModel {
  final List<DateTime> dates;
  final List<double> values;
  final String label;
  final Color color;

  LineChartDataModel({
    required this.dates,
    required this.values,
    required this.label,
    required this.color,
  });
}

class CustomLineChart extends StatefulWidget {
  final List<LineChartDataModel> data;
  final String title;
  final Function(int, double, DateTime)? onPointClick;

  const CustomLineChart({
    Key? key,
    required this.data,
    this.title = '折线图',
    this.onPointClick,
  }) : super(key: key);

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: LineChartWidget(
            data: widget.data,
            touchedIndex: _touchedIndex,
            onPointTap: (index, value, date) {
              setState(() {
                _touchedIndex = index;
              });
              if (widget.onPointClick != null) {
                widget.onPointClick!(index, value, date);
              }
            },
            onTooltipClose: () {
              setState(() {
                _touchedIndex = null;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: widget.data.map((series) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: series.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(series.label),
          ],
        );
      }).toList(),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final List<LineChartDataModel> data;
  final int? touchedIndex;
  final Function(int, double, DateTime)? onPointTap;
  final Function()? onTooltipClose;

  const LineChartWidget({
    Key? key,
    required this.data,
    this.touchedIndex,
    this.onPointTap,
    this.onTooltipClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < data[0].dates.length) {
                  final date = data[0].dates[index];
                  return Text('${date.month}/${date.day}');
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}');
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        minX: 0,
        maxX: (data.isNotEmpty ? data[0].dates.length - 1 : 0).toDouble(),
        minY: 0,
        maxY: _getMaxY(),
        lineBarsData: _getLineBarsData(),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final seriesIndex = spot.barIndex;
                final dataIndex = spot.x.toInt();
                final series = data[seriesIndex];
                final value = series.values[dataIndex];
                final date = series.dates[dataIndex];

                return LineTooltipItem(
                  '${series.label}: ${value.toStringAsFixed(1)}\nDate: ${date.month}/${date.day}',
                  TextStyle(color: series.color),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
          touchCallback: (event, response) {
            if (onTooltipClose != null && event is FlPointerExitEvent) {
              onTooltipClose!();
            }
          },
        ),
      ),
    );
  }

  double _getMaxY() {
    double max = 0;
    for (var series in data) {
      for (var value in series.values) {
        if (value > max) {
          max = value;
        }
      }
    }
    return max * 1.1; // Add 10% padding
  }

  List<LineChartBarData> _getLineBarsData() {
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final series = entry.value;
      return LineChartBarData(
        spots: series.values.asMap().entries.map((valueEntry) {
          return FlSpot(valueEntry.key.toDouble(), valueEntry.value);
        }).toList(),
        isCurved: true,
        color: series.color,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 6,
              color: barData.color ?? Colors.blue,
              strokeWidth: 2,
              strokeColor: Colors.white,
            );
          },
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );
    }).toList() as List<LineChartBarData>;
  }
}