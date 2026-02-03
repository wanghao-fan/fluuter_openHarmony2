import 'package:flutter/material.dart';

class PhysicsAnimation extends StatefulWidget {
  const PhysicsAnimation({Key? key}) : super(key: key);

  @override
  _PhysicsAnimationState createState() => _PhysicsAnimationState();
}

class _PhysicsAnimationState extends State<PhysicsAnimation> with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  
  // 弹簧动画
  late Animation<double> _springAnimation;
  
  // 重力动画
  late Animation<double> _gravityAnimation;
  
  // 滚动动画
  late Animation<double> _scrollAnimation;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // 初始化弹簧动画
    _springAnimation = _controller.drive(
      Tween<double>(begin: 0, end: 1).chain(
        CurveTween(curve: Curves.elasticOut),
      ),
    );
    
    // 初始化重力动画
    _gravityAnimation = _controller.drive(
      Tween<double>(begin: -100, end: 200).chain(
        CurveTween(curve: Curves.decelerate),
      ),
    );
    
    // 初始化滚动动画
    _scrollAnimation = _controller.drive(
      Tween<double>(begin: -200, end: 200).chain(
        CurveTween(curve: Curves.elasticInOut),
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
                  '物理动画效果展示:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('1. 弹簧动画 - 使用 Curves.elasticOut'),
                Text('2. 重力动画 - 使用 Curves.decelerate'),
                Text('3. 滚动动画 - 使用 Curves.elasticInOut'),
                Text('4. 组合物理动画 - 多种效果结合'),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 1. 弹簧动画
          Container(
            height: 150,
            child: AnimatedBuilder(
              animation: _springAnimation,
              builder: (context, child) {
                return Center(
                  child: Container(
                    width: 100 + _springAnimation.value * 50,
                    height: 100 + _springAnimation.value * 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        '弹簧动画',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 2. 重力动画
          Container(
            height: 300,
            child: AnimatedBuilder(
              animation: _gravityAnimation,
              builder: (context, child) {
                return Center(
                  child: Transform.translate(
                    offset: Offset(0, _gravityAnimation.value),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '重力动画',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 3. 滚动动画
          Container(
            height: 150,
            child: AnimatedBuilder(
              animation: _scrollAnimation,
              builder: (context, child) {
                return Center(
                  child: Transform.translate(
                    offset: Offset(_scrollAnimation.value, 0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '滚动动画',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 4. 组合物理动画
          Container(
            height: 200,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Center(
                  child: Transform.translate(
                    offset: Offset(
                      _scrollAnimation.value * 0.5,
                      _gravityAnimation.value * 0.3,
                    ),
                    child: Transform.scale(
                      scale: 0.8 + _springAnimation.value * 0.4,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}