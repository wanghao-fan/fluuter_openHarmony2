import 'package:flutter/material.dart';

class AnimatedContainerComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color initialColor;
  final Color targetColor;
  final double initialSize;
  final double targetSize;
  final BorderRadius initialBorderRadius;
  final BorderRadius targetBorderRadius;
  final Duration animationDuration;
  final VoidCallback? onTap;

  const AnimatedContainerComponent({
    Key? key,
    this.title = 'AnimatedContainer',
    this.subtitle = '点击查看过渡效果',
    this.initialColor = Colors.blue,
    this.targetColor = Colors.green,
    this.initialSize = 150.0,
    this.targetSize = 200.0,
    this.initialBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.targetBorderRadius = const BorderRadius.all(Radius.circular(24)),
    this.animationDuration = const Duration(seconds: 1),
    this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedContainerComponent> createState() => _AnimatedContainerComponentState();
}

class _AnimatedContainerComponentState extends State<AnimatedContainerComponent> {
  bool _isAnimating = false;
  bool _isTargetState = false;

  void toggleAnimation() {
    setState(() {
      _isAnimating = true;
      _isTargetState = !_isTargetState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleAnimation();
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
                color: _isTargetState ? widget.targetColor : widget.initialColor,
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
            AnimatedContainer(
              width: _isTargetState ? widget.targetSize : widget.initialSize,
              height: _isTargetState ? widget.targetSize : widget.initialSize,
              decoration: BoxDecoration(
                color: _isTargetState ? widget.targetColor : widget.initialColor,
                borderRadius: _isTargetState ? widget.targetBorderRadius : widget.initialBorderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isTargetState ? Icons.check_circle : Icons.touch_app,
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _isTargetState ? '目标状态' : '初始状态',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '点击容器查看平滑过渡效果',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
