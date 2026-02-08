import 'package:flutter/material.dart';

class ThreeDRotationComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color boxColor;
  final Color textColor;
  final double size;
  final int animationDuration;
  final VoidCallback? onTap;

  const ThreeDRotationComponent({
    Key? key,
    this.title = '3D旋转效果',
    this.subtitle = '点击查看更多',
    this.boxColor = Colors.blue,
    this.textColor = Colors.white,
    this.size = 200.0,
    this.animationDuration = 2000,
    this.onTap,
  }) : super(key: key);

  @override
  State<ThreeDRotationComponent> createState() => _ThreeDRotationComponentState();
}

class _ThreeDRotationComponentState extends State<ThreeDRotationComponent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isRotating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startRotation() {
    setState(() {
      _isRotating = true;
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        startRotation();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // 透视效果
                ..rotateX(_isRotating ? _animation.value * 3.14159 * 2 : 0)
                ..rotateY(_isRotating ? _animation.value * 3.14159 * 2 : 0),
              alignment: Alignment.center,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: widget.boxColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.textColor.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Icon(
                      Icons.rotate_right,
                      size: 40,
                      color: widget.textColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
