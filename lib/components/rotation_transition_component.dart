import 'package:flutter/material.dart';

class RotationTransitionComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget? child;
  final Duration animationDuration;
  final bool clockwise;
  final VoidCallback? onTap;

  const RotationTransitionComponent({
    Key? key,
    this.title = 'RotationTransition',
    this.subtitle = '点击查看旋转动画',
    this.child,
    this.animationDuration = const Duration(seconds: 1),
    this.clockwise = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<RotationTransitionComponent> createState() => _RotationTransitionComponentState();
}

class _RotationTransitionComponentState extends State<RotationTransitionComponent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRotated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleRotation() {
    setState(() {
      if (_isRotated) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isRotated = !_isRotated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleRotation();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            RotationTransition(
              turns: _animation,
              child: widget.child ?? Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '点击旋转',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '点击查看旋转动画效果',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isRotated ? '旋转中...' : '点击开始旋转',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
