import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

// 共享轴过渡组件
class SharedAxisTransitionComponent extends StatefulWidget {
  const SharedAxisTransitionComponent({super.key});

  @override
  State<SharedAxisTransitionComponent> createState() => _SharedAxisTransitionComponentState();
}

class _SharedAxisTransitionComponentState extends State<SharedAxisTransitionComponent> {
  // 当前页面索引
  int _currentIndex = 0;
  
  // 页面数据
  final List<Map<String, dynamic>> _pages = [
    {
      'title': '页面 1',
      'color': Colors.blue,
      'content': '这是第一个页面，展示共享轴过渡效果',
    },
    {
      'title': '页面 2',
      'color': Colors.green,
      'content': '这是第二个页面，通过共享轴动画过渡而来',
    },
    {
      'title': '页面 3',
      'color': Colors.orange,
      'content': '这是第三个页面，继续使用共享轴动画',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            '共享轴过渡效果',
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
              '共享轴过渡效果可以为页面切换提供流畅的动画体验。点击下方的页面指示器可以切换页面，观察动画效果。',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // 动画区域
          SizedBox(
            height: 300,
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey<int>(_currentIndex),
                decoration: BoxDecoration(
                  color: _pages[_currentIndex]['color'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _pages[_currentIndex]['title'] as String,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        _pages[_currentIndex]['content'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // 页面指示器
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.deepPurple
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
