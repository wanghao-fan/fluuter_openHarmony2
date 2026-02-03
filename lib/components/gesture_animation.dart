import 'package:flutter/material.dart';

class GestureAnimation extends StatefulWidget {
  const GestureAnimation({Key? key}) : super(key: key);

  @override
  _GestureAnimationState createState() => _GestureAnimationState();
}

class _GestureAnimationState extends State<GestureAnimation> with SingleTickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;
  
  // 点击动画
  late Animation<double> _tapAnimation;
  
  // 双击动画
  late Animation<double> _doubleTapAnimation;
  
  // 长按动画
  late Animation<double> _longPressAnimation;
  
  // 拖拽位置
  Offset _dragPosition = Offset(0, 0);
  
  // 缩放比例
  double _scale = 1.0;
  
  // 滑动位置
  Offset _swipePosition = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    // 初始化点击动画
    _tapAnimation = _controller.drive(
      Tween<double>(begin: 1, end: 0.8).chain(
        CurveTween(curve: Curves.easeOut),
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    
    // 初始化双击动画
    _doubleTapAnimation = _controller.drive(
      Tween<double>(begin: 1, end: 1.2).chain(
        CurveTween(curve: Curves.bounceOut),
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    
    // 初始化长按动画
    _longPressAnimation = _controller.drive(
      Tween<double>(begin: 1, end: 1.1).chain(
        CurveTween(curve: Curves.elasticOut),
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
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
                  '手势动画效果展示:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('1. 点击动画 - 点击方块查看效果'),
                Text('2. 双击动画 - 双击方块查看效果'),
                Text('3. 长按动画 - 长按方块查看效果'),
                Text('4. 拖拽动画 - 按住方块拖动查看效果'),
                Text('5. 缩放动画 - 双指捏合方块查看效果'),
                Text('6. 滑动动画 - 左右滑动方块查看效果'),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 1. 点击动画
          Container(
            height: 150,
            child: GestureDetector(
              onTap: () {
                _controller.forward(from: 0);
              },
              child: ScaleTransition(
                scale: _tapAnimation,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '点击动画',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 2. 双击动画
          Container(
            height: 150,
            child: GestureDetector(
              onDoubleTap: () {
                _controller.forward(from: 0);
              },
              child: ScaleTransition(
                scale: _doubleTapAnimation,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '双击动画',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 3. 长按动画
          Container(
            height: 150,
            child: GestureDetector(
              onLongPress: () {
                _controller.forward(from: 0);
              },
              child: ScaleTransition(
                scale: _longPressAnimation,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '长按动画',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 4. 拖拽动画
          Container(
            height: 150,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta;
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _dragPosition = Offset(0, 0);
                });
              },
              child: Transform.translate(
                offset: _dragPosition,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '拖拽动画',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // 5. 缩放动画
          Container(
            height: 150,
            child: GestureDetector(
              onScaleUpdate: (details) {
                setState(() {
                  _scale = details.scale;
                });
              },
              onScaleEnd: (details) {
                setState(() {
                  _scale = 1.0;
                });
              },
              child: Transform.scale(
                scale: _scale,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.purple,
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
          ),
          
          const SizedBox(height: 30),
          
          // 6. 滑动动画
          Container(
            height: 150,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _swipePosition += Offset(details.delta.dx, 0);
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  _swipePosition = Offset(0, 0);
                });
              },
              child: Transform.translate(
                offset: _swipePosition,
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.orange,
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
          ),
        ],
      ),
    );
  }
}