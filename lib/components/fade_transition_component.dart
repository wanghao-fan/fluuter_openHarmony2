import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class FadeTransitionComponent extends StatefulWidget {
  const FadeTransitionComponent({Key? key}) : super(key: key);

  @override
  State<FadeTransitionComponent> createState() => _FadeTransitionComponentState();
}

class _FadeTransitionComponentState extends State<FadeTransitionComponent> {
  int _currentIndex = 0;
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

  void _nextColor() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _colors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            '淡出过渡效果',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            width: double.infinity,
            child: PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey<int>(_currentIndex),
                decoration: BoxDecoration(
                  color: _colors[_currentIndex],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '颜色 ${_currentIndex + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _nextColor,
            child: const Text('切换颜色'),
          ),
          const SizedBox(height: 10),
          const Text(
            '点击按钮查看淡出过渡效果',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
