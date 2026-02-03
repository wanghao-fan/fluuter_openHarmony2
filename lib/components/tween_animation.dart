import 'package:flutter/material.dart';

class TweenAnimation extends StatefulWidget {
  const TweenAnimation({Key? key}) : super(key: key);

  @override
  _TweenAnimationState createState() => _TweenAnimationState();
}

class _TweenAnimationState extends State<TweenAnimation> with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  
  // 颜色补间动画
  late Animation<Color?> _colorAnimation;
  
  // 大小补间动画
  late Animation<double> _sizeAnimation;
  
  // 位置补间动画
  late Animation<Offset> _positionAnimation;
  
  // 旋转补间动画
  late Animation<double> _rotationAnimation;
  
  // 透明度补间动画
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器，时长3秒
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    // 初始化颜色补间动画
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    // 初始化大小补间动画
    _sizeAnimation = Tween<double>(
      begin: 50.0,
      end: 150.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    
    // 初始化位置补间动画
    _positionAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    // 初始化旋转补间动画
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    
    // 初始化透明度补间动画
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    // 启动动画，重复执行并反向
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
                    '补间动画效果展示:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('1. 颜色渐变动画 - 使用 ColorTween'),
                  Text('2. 大小变化动画 - 使用 Tween<double>'),
                  Text('3. 位置变化动画 - 使用 Tween<Offset>'),
                  Text('4. 旋转动画 - 使用 Tween<double>'),
                  Text('5. 透明度变化动画 - 使用 Tween<double>'),
                  Text('6. 组合补间动画 - 多种效果结合'),
                ],
              ),
            ),
            
            // 1. 颜色渐变动画
            Container(
              height: 100,
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        '颜色渐变',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // 2. 大小变化动画
            Container(
              height: 200,
              child: AnimatedBuilder(
                animation: _sizeAnimation,
                builder: (context, child) {
                  return Center(
                    child: Container(
                      width: _sizeAnimation.value,
                      height: _sizeAnimation.value,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '大小变化',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // 3. 位置变化动画
            Container(
              height: 100,
              child: SlideTransition(
                position: _positionAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '位置变化',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            
            // 4. 旋转动画
            Container(
              height: 100,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '旋转',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // 5. 透明度变化动画
            Container(
              height: 100,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '透明度变化',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            
            // 6. 组合补间动画
            Container(
              height: 150,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Container(
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                        decoration: BoxDecoration(
                          color: _colorAnimation.value,
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
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}