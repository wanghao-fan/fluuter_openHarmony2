import 'package:flutter/material.dart';

class TransitionAnimation extends StatefulWidget {
  const TransitionAnimation({Key? key}) : super(key: key);

  @override
  _TransitionAnimationState createState() => _TransitionAnimationState();
}

class _TransitionAnimationState extends State<TransitionAnimation> with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  
  // 淡入淡出动画
  late Animation<double> _fadeAnimation;
  
  // 滑动动画
  late Animation<Offset> _slideAnimation;
  
  // 缩放动画
  late Animation<double> _scaleAnimation;
  
  // 旋转动画
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // 初始化淡入淡出动画
    _fadeAnimation = _controller.drive(
      Tween<double>(begin: 0, end: 1),
    );
    
    // 初始化滑动动画
    _slideAnimation = _controller.drive(
      Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).chain(
        CurveTween(curve: Curves.easeOut),
      ),
    );
    
    // 初始化缩放动画
    _scaleAnimation = _controller.drive(
      Tween<double>(begin: 0, end: 1).chain(
        CurveTween(curve: Curves.bounceOut),
      ),
    );
    
    // 初始化旋转动画
    _rotationAnimation = _controller.drive(
      Tween<double>(begin: 0, end: 2 * 3.14159).chain(
        CurveTween(curve: Curves.easeInOut),
      ),
    );
    
    // 启动动画
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
                  '转场动画效果展示:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('1. 淡入淡出动画 - Fade Transition'),
                Text('2. 滑动动画 - Slide Transition'),
                Text('3. 缩放动画 - Scale Transition'),
                Text('4. 旋转动画 - Rotation Transition'),
                Text('5. 组合转场动画 - 多种效果结合'),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 1. 淡入淡出动画
          Container(
            height: 150,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    '淡入淡出动画',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 2. 滑动动画
          Container(
            height: 150,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    '滑动动画',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 3. 缩放动画
          Container(
            height: 150,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
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
          
          const SizedBox(height: 30),
          
          // 4. 旋转动画
          Container(
            height: 150,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    '旋转动画',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 5. 组合转场动画
          Container(
            height: 150,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        '组合转场动画',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}