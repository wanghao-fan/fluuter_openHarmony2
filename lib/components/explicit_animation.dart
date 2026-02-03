import 'package:flutter/material.dart';

/// 显式动画演示组件
class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({super.key});

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation> with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  
  // 淡入淡出动画
  late Animation<double> _fadeAnimation;
  
  // 缩放动画
  late Animation<double> _scaleAnimation;
  
  // 平移动画
  late Animation<Offset> _translateAnimation;
  
  // 旋转动画
  late Animation<double> _rotateAnimation;
  
  // 组合动画状态
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器，时长2秒
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // 初始化淡入淡出动画
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    // 初始化缩放动画
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    
    // 初始化平移动画
    _translateAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    // 初始化旋转动画
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    
    // 启动动画
    _startAnimation();
  }

  // 启动动画
  void _startAnimation() {
    setState(() {
      _isAnimating = true;
    });
    
    // 重复执行动画
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // 释放动画控制器
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('显式动画演示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 动画效果说明
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '显式动画效果展示:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('1. 淡入淡出动画 - 使用 FadeTransition'),
                  Text('2. 缩放动画 - 使用 ScaleTransition'),
                  Text('3. 平移动画 - 使用 SlideTransition'),
                  Text('4. 旋转动画 - 使用 RotationTransition'),
                  Text('5. 组合动画 - 多种动画效果结合'),
                ],
              ),
            ),
            
            // 1. 淡入淡出动画
            Container(
              height: 100,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '淡入淡出',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            
            // 2. 缩放动画
            Container(
              height: 100,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '缩放',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            
            // 3. 平移动画
            Container(
              height: 100,
              child: SlideTransition(
                position: _translateAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '平移',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            
            // 4. 旋转动画
            Container(
              height: 100,
              child: RotationTransition(
                turns: _controller,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '旋转',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            
            // 5. 组合动画
            Container(
              height: 100,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: RotationTransition(
                    turns: _controller,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '组合动画',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}