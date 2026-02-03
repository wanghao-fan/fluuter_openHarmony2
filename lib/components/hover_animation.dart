import 'package:flutter/material.dart';

class HoverAnimation extends StatefulWidget {
  const HoverAnimation({Key? key}) : super(key: key);

  @override
  _HoverAnimationState createState() => _HoverAnimationState();
}

class _HoverAnimationState extends State<HoverAnimation> with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  
  // 缩放动画
  late Animation<double> _scaleAnimation;
  
  // 颜色动画
  late Animation<Color?> _colorAnimation;
  
  // 阴影动画
  late Animation<double> _shadowAnimation;
  
  // 悬停状态
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // 初始化缩放动画
    _scaleAnimation = _controller.drive(
      Tween<double>(begin: 1, end: 1.1).chain(
        CurveTween(curve: Curves.easeOut),
      ),
    );
    
    // 初始化颜色动画
    _colorAnimation = _controller.drive(
      ColorTween(
        begin: Colors.blue,
        end: Colors.blue.shade700,
      ).chain(
        CurveTween(curve: Curves.easeOut),
      ),
    );
    
    // 初始化阴影动画
    _shadowAnimation = _controller.drive(
      Tween<double>(begin: 5, end: 15).chain(
        CurveTween(curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    // 释放动画控制器
    _controller.dispose();
    super.dispose();
  }

  // 处理鼠标进入事件
  void _onMouseEnter([dynamic event]) {
    setState(() {
      _isHovered = true;
      _controller.forward();
    });
  }

  // 处理鼠标离开事件
  void _onMouseLeave([dynamic event]) {
    setState(() {
      _isHovered = false;
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 动画效果说明
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '悬停动画效果展示:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('1. 缩放动画 - 鼠标悬停时放大'),
                Text('2. 颜色动画 - 鼠标悬停时颜色变深'),
                Text('3. 阴影动画 - 鼠标悬停时阴影增强'),
                Text('4. 组合动画 - 同时展示多种效果'),
              ],
            ),
          ),
          
          const SizedBox(height: 50),
          
          // 1. 缩放动画
          Container(
            height: 150,
            child: MouseRegion(
              onEnter: _onMouseEnter,
              onExit: _onMouseLeave,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '缩放动画',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 50),
          
          // 2. 颜色动画
          Container(
            height: 150,
            child: MouseRegion(
              onEnter: _onMouseEnter,
              onExit: _onMouseLeave,
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        '颜色动画',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 50),
          
          // 3. 阴影动画
          Container(
            height: 150,
            child: MouseRegion(
              onEnter: _onMouseEnter,
              onExit: _onMouseLeave,
              child: AnimatedBuilder(
                animation: _shadowAnimation,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: _shadowAnimation.value,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        '阴影动画',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 50),
          
          // 4. 组合动画
          Container(
            height: 150,
            child: MouseRegion(
              onEnter: _onMouseEnter,
              onExit: _onMouseLeave,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedBuilder(
                  animation: Listenable.merge([_colorAnimation, _shadowAnimation]),
                  builder: (context, child) {
                    return Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: _shadowAnimation.value,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '组合动画',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}