import 'package:flutter/material.dart';

class ShakeAnimationComponent extends StatefulWidget {
  final String errorMessage;
  final String title;
  final Color backgroundColor;
  final Color errorColor;
  final double shakeAmplitude;
  final int shakeDuration;
  final VoidCallback? onTap;

  const ShakeAnimationComponent({
    Key? key,
    required this.errorMessage,
    this.title = '错误提示',
    this.backgroundColor = Colors.white,
    this.errorColor = Colors.red,
    this.shakeAmplitude = 0.05,
    this.shakeDuration = 500,
    this.onTap,
  }) : super(key: key);

  @override
  State<ShakeAnimationComponent> createState() => _ShakeAnimationComponentState();
}

class _ShakeAnimationComponentState extends State<ShakeAnimationComponent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isShaking = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.shakeDuration),
      vsync: this,
    );

    _animation = Tween<double>(begin: -widget.shakeAmplitude, end: widget.shakeAmplitude)
        .chain(CurveTween(curve: Curves.linear))
        .animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    // 初始时触发一次抖动
    Future.delayed(const Duration(milliseconds: 500), () {
      startShake();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startShake() {
    setState(() {
      _isShaking = true;
    });
    _controller.forward();
    
    // 3秒后停止抖动
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isShaking = false;
      });
      _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击时重新触发抖动
        startShake();
        // 调用外部传入的回调函数
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _isShaking ? _animation.value : 0,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: widget.errorColor,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 24,
                    color: widget.errorColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.errorColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.errorMessage,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '点击重试',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.errorColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
