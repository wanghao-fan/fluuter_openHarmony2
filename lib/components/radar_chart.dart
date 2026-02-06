import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class RadarChartComponent extends StatefulWidget {
  const RadarChartComponent({super.key});

  @override
  State<RadarChartComponent> createState() => _RadarChartComponentState();
}

class _RadarChartComponentState extends State<RadarChartComponent> {
  int _selectedIndex = -1;
  bool _isExpanded = false;

  // Sample data for radar chart
  final List<String> categories = [
    '力量',
    '速度',
    '耐力',
    '技巧',
    '敏捷',
    '智力',
  ];

  final List<double> data = [65, 75, 80, 70, 85, 90];

  // Calculate label offset based on index and total count
  Offset _getLabelOffset(int index, int total, double height) {
    double angle = (index / total) * 2 * 3.14159265359 - 3.14159265359 / 2;
    double radius = (height / 2) * 0.6;
    double x = radius * cos(angle);
    double y = radius * sin(angle);
    
    // Adjust for label size
    if (x > 0) x += 15;
    if (x < 0) x -= 30;
    if (y > 0) y += 15;
    if (y < 0) y -= 15;
    
    return Offset(x, y);
  }

  // Helper method for cosine
  double cos(double angle) {
    return math.cos(angle);
  }

  // Helper method for sine
  double sin(double angle) {
    return math.sin(angle);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '能力雷达图',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                        // Add random selection for interaction
                        if (_isExpanded) {
                          _selectedIndex = math.Random().nextInt(categories.length);
                        }
                      });
                    },
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: _isExpanded ? 400 : 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RadarChart(
                      RadarChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        radarTouchData: RadarTouchData(
                          touchCallback: (FlTouchEvent event, RadarTouchResponse? response) {
                            setState(() {
                              if (event is FlTapUpEvent) {
                                _selectedIndex = math.Random().nextInt(categories.length);
                              }
                            });
                          },
                        ),
                        tickCount: 5,
                        ticksTextStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        dataSets: [
                          RadarDataSet(
                            fillColor: Colors.deepPurple.withOpacity(0.2),
                            borderColor: Colors.deepPurple,
                            borderWidth: 2,
                            entryRadius: 4,
                            dataEntries: categories.asMap().entries.map((entry) {
                              int index = entry.key;
                              return RadarEntry(
                                value: data[index],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 400),
                    ),
                    // Manually add category labels
                    for (int i = 0; i < categories.length; i++)
                      Positioned(
                        child: Transform.translate(
                          offset: _getLabelOffset(i, categories.length, _isExpanded ? 400 : 300),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              categories[i],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_selectedIndex != -1)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(0.1),
                  ),
                  child: Text(
                    '${categories[_selectedIndex]}: ${data[_selectedIndex]}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              if (_isExpanded)
                Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      '数据详情',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: categories.asMap().entries.map((entry) {
                        int index = entry.key;
                        String category = entry.value;
                        double value = data[index];
                        return Chip(
                          label: Text('$category: $value'),
                          backgroundColor: Colors.deepPurple.withOpacity(0.1),
                          labelStyle: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
