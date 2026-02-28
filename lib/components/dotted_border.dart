import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class DottedBorderComponent extends StatefulWidget {
  const DottedBorderComponent({Key? key}) : super(key: key);

  @override
  _DottedBorderComponentState createState() => _DottedBorderComponentState();
}

class _DottedBorderComponentState extends State<DottedBorderComponent> {
  int _selectedIndex = -1;

  final List<String> _borderTypes = [
    'Rect',
    'RRect',
    'Circle',
    'Oval',
  ];

  void _onBorderTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // 点击时的交互效果
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You selected ${_borderTypes[index]} border'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _borderTypes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onBorderTap(index),
          child: Container(
            child: _buildBorderType(index),
          ),
        );
      },
    );
  }

  Widget _buildBorderType(int index) {
    switch (index) {
      case 0:
        return DottedBorder(
          borderType: BorderType.Rect,
          color: _selectedIndex == index ? Colors.blue : Colors.grey,
          strokeWidth: 2,
          dashPattern: [8, 4],
          child: Container(
            width: double.infinity,
            height: 150,
            child: Center(
              child: Text(
                _borderTypes[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _selectedIndex == index ? Colors.blue : Colors.black,
                ),
              ),
            ),
          ),
        );
      case 1:
        return DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          color: _selectedIndex == index ? Colors.green : Colors.grey,
          strokeWidth: 2,
          dashPattern: [10, 5],
          child: Container(
            width: double.infinity,
            height: 150,
            child: Center(
              child: Text(
                _borderTypes[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _selectedIndex == index ? Colors.green : Colors.black,
                ),
              ),
            ),
          ),
        );
      case 2:
        return DottedBorder(
          borderType: BorderType.Circle,
          color: _selectedIndex == index ? Colors.red : Colors.grey,
          strokeWidth: 2,
          dashPattern: [6, 3],
          child: Container(
            width: double.infinity,
            height: 150,
            child: Center(
              child: Text(
                _borderTypes[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _selectedIndex == index ? Colors.red : Colors.black,
                ),
              ),
            ),
          ),
        );
      case 3:
        return DottedBorder(
          borderType: BorderType.Oval,
          color: _selectedIndex == index ? Colors.purple : Colors.grey,
          strokeWidth: 2,
          dashPattern: [12, 6],
          child: Container(
            width: double.infinity,
            height: 150,
            child: Center(
              child: Text(
                _borderTypes[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _selectedIndex == index ? Colors.purple : Colors.black,
                ),
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
