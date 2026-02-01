import 'package:flutter/material.dart';

class SliderDemo extends StatefulWidget {
  const SliderDemo({super.key});

  @override
  State<SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _sliderValue = 50.0;
  RangeValues _rangeValues = const RangeValues(20.0, 80.0);
  double _discreteValue = 2.0;
  double _labelValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基本滑块',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildBasicSlider(),
          const SizedBox(height: 32.0),

          const Text(
            '带标签的滑块',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildLabeledSlider(),
          const SizedBox(height: 32.0),

          const Text(
            '离散滑块',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildDiscreteSlider(),
          const SizedBox(height: 32.0),

          const Text(
            '范围滑块',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildRangeSlider(),
          const SizedBox(height: 32.0),

          const Text(
            '自定义样式滑块',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildCustomSlider(),
        ],
      ),
    );
  }

  Widget _buildBasicSlider() {
    return Column(
      children: [
        Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
        Text('当前值: ${_sliderValue.toStringAsFixed(1)}'),
      ],
    );
  }

  Widget _buildLabeledSlider() {
    return Column(
      children: [
        Slider(
          value: _labelValue,
          min: 0,
          max: 100,
          divisions: 5,
          label: _labelValue.round().toString(),
          onChanged: (value) {
            setState(() {
              _labelValue = value;
            });
          },
        ),
        Text('当前值: ${_labelValue.toStringAsFixed(1)}'),
      ],
    );
  }

  Widget _buildDiscreteSlider() {
    return Column(
      children: [
        Slider(
          value: _discreteValue,
          min: 0,
          max: 10,
          divisions: 10,
          onChanged: (value) {
            setState(() {
              _discreteValue = value;
            });
          },
        ),
        Text('当前值: ${_discreteValue.toStringAsFixed(1)}'),
      ],
    );
  }

  Widget _buildRangeSlider() {
    return Column(
      children: [
        RangeSlider(
          values: _rangeValues,
          min: 0,
          max: 100,
          onChanged: (values) {
            setState(() {
              _rangeValues = values;
            });
          },
        ),
        Text('当前范围: ${_rangeValues.start.toStringAsFixed(1)} - ${_rangeValues.end.toStringAsFixed(1)}'),
      ],
    );
  }

  Widget _buildCustomSlider() {
    return Column(
      children: [
        Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
          },
          activeColor: Colors.green,
          inactiveColor: Colors.grey[300],
          thumbColor: Colors.green,
        ),
        Text('当前值: ${_sliderValue.toStringAsFixed(1)}'),
      ],
    );
  }
}
