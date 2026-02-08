import 'package:flutter/material.dart';

class AnimatedDefaultTextStyleComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final String text;
  final TextStyle initialTextStyle;
  final TextStyle targetTextStyle;
  final Duration animationDuration;
  final VoidCallback? onTap;

  const AnimatedDefaultTextStyleComponent({
    Key? key,
    this.title = 'AnimatedDefaultTextStyle',
    this.subtitle = '点击查看文本样式动画',
    this.text = 'Flutter for OpenHarmony',
    TextStyle? initialTextStyle,
    TextStyle? targetTextStyle,
    this.animationDuration = const Duration(seconds: 1),
    this.onTap,
  })  : initialTextStyle = initialTextStyle ?? const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        targetTextStyle = targetTextStyle ?? const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontStyle: FontStyle.italic,
        ),
        super(key: key);

  @override
  State<AnimatedDefaultTextStyleComponent> createState() => _AnimatedDefaultTextStyleComponentState();
}

class _AnimatedDefaultTextStyleComponentState extends State<AnimatedDefaultTextStyleComponent> {
  bool _isTargetState = false;

  void toggleAnimation() {
    setState(() {
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
                color: _isTargetState ? widget.targetTextStyle.color : widget.initialTextStyle.color,
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
            AnimatedDefaultTextStyle(
              style: _isTargetState ? widget.targetTextStyle : widget.initialTextStyle,
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              child: Text(widget.text),
            ),
            const SizedBox(height: 16),
            Text(
              '点击查看文本样式动画效果',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isTargetState ? '目标样式' : '初始样式',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _isTargetState ? widget.targetTextStyle.color : widget.initialTextStyle.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
