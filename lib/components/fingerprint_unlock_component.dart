import 'package:flutter/material.dart';

class FingerprintUnlockComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color fingerprintColor;
  final Color scanColor;
  final double size;
  final int animationDuration;
  final VoidCallback? onUnlock;
  final VoidCallback? onFailed;

  const FingerprintUnlockComponent({
    Key? key,
    this.title = '指纹解锁',
    this.subtitle = '点击指纹区域解锁',
    this.backgroundColor = Colors.white,
    this.fingerprintColor = Colors.blue,
    this.scanColor = Colors.green,
    this.size = 200.0,
    this.animationDuration = 2000,
    this.onUnlock,
    this.onFailed,
  }) : super(key: key);

  @override
  State<FingerprintUnlockComponent> createState() => _FingerprintUnlockComponentState();
}

class _FingerprintUnlockComponentState extends State<FingerprintUnlockComponent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isScanning = false;
  bool _isUnlocked = false;
  bool _isFailed = false;

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
          _isScanning = false;
          // 模拟解锁结果，80%概率成功
          if (DateTime.now().millisecond % 10 < 8) {
            _isUnlocked = true;
            if (widget.onUnlock != null) {
              widget.onUnlock!();
            }
          } else {
            _isFailed = true;
            if (widget.onFailed != null) {
              widget.onFailed!();
            }
            // 2秒后重置失败状态
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                _isFailed = false;
              });
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startScanning() {
    if (!_isScanning && !_isUnlocked) {
      setState(() {
        _isScanning = true;
        _isFailed = false;
      });
      _controller.reset();
      _controller.forward();
    }
  }

  void resetUnlock() {
    setState(() {
      _isUnlocked = false;
      _isFailed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isScanning) {
          if (_isUnlocked) {
            resetUnlock();
          } else {
            startScanning();
          }
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
                color: widget.fingerprintColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isUnlocked ? '解锁成功' : _isFailed ? '解锁失败' : widget.subtitle,
              style: TextStyle(
                fontSize: 14,
                color: _isUnlocked ? Colors.green : _isFailed ? Colors.red : Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: FingerprintPainter(
                      isScanning: _isScanning,
                      isUnlocked: _isUnlocked,
                      isFailed: _isFailed,
                      progress: _animation.value,
                      fingerprintColor: widget.fingerprintColor,
                      scanColor: widget.scanColor,
                    ),
                  );
                },
              ),
            ),
            if (_isUnlocked)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: resetUnlock,
                  child: const Text('重新解锁'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FingerprintPainter extends CustomPainter {
  final bool isScanning;
  final bool isUnlocked;
  final bool isFailed;
  final double progress;
  final Color fingerprintColor;
  final Color scanColor;

  FingerprintPainter({
    required this.isScanning,
    required this.isUnlocked,
    required this.isFailed,
    required this.progress,
    required this.fingerprintColor,
    required this.scanColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 绘制指纹外圈
    final outerCirclePaint = Paint()
      ..color = isUnlocked ? scanColor : isFailed ? Colors.red : fingerprintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 10, outerCirclePaint);

    // 绘制指纹图案
    final fingerprintPaint = Paint()
      ..color = isUnlocked ? scanColor : isFailed ? Colors.red : fingerprintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // 绘制指纹曲线
    final path = Path();
    path.moveTo(center.dx, center.dy - radius * 0.6);
    
    // 绘制指纹的波浪线
    for (double angle = 0; angle < 3.14159 * 2; angle += 0.1) {
      final r = radius * 0.6 * (1 + 0.2 * (1 - (angle / (3.14159 * 2))));
      final x = center.dx + r * 0.8 * (angle < 3.14159 ? 1 : -1);
      final y = center.dy + r * 0.6 * (angle < 3.14159 ? 1 : -1);
      path.lineTo(x, y);
    }
    
    path.close();
    canvas.drawPath(path, fingerprintPaint);

    // 绘制扫描线
    if (isScanning) {
      final scanLinePaint = Paint()
        ..color = scanColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [scanColor.withOpacity(0), scanColor, scanColor.withOpacity(0)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      final scanY = center.dy - radius * 0.8 + progress * radius * 1.6;
      canvas.drawLine(
        Offset(center.dx - radius * 0.8, scanY),
        Offset(center.dx + radius * 0.8, scanY),
        scanLinePaint,
      );

      // 绘制扫描波纹
      final ripplePaint = Paint()
        ..color = scanColor.withOpacity(0.3 * (1 - progress))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(center, radius * 0.8 * progress, ripplePaint);
    }

    // 绘制解锁成功或失败图标
    if (isUnlocked) {
      final checkPaint = Paint()
        ..color = scanColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final checkPath = Path();
      checkPath.moveTo(center.dx - radius * 0.3, center.dy);
      checkPath.lineTo(center.dx - radius * 0.1, center.dy + radius * 0.2);
      checkPath.lineTo(center.dx + radius * 0.3, center.dy - radius * 0.2);
      canvas.drawPath(checkPath, checkPaint);
    } else if (isFailed) {
      final crossPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      canvas.drawLine(
        Offset(center.dx - radius * 0.3, center.dy - radius * 0.3),
        Offset(center.dx + radius * 0.3, center.dy + radius * 0.3),
        crossPaint,
      );
      canvas.drawLine(
        Offset(center.dx + radius * 0.3, center.dy - radius * 0.3),
        Offset(center.dx - radius * 0.3, center.dy + radius * 0.3),
        crossPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FingerprintPainter oldDelegate) {
    return oldDelegate.isScanning != isScanning ||
           oldDelegate.isUnlocked != isUnlocked ||
           oldDelegate.isFailed != isFailed ||
           oldDelegate.progress != progress ||
           oldDelegate.fingerprintColor != fingerprintColor ||
           oldDelegate.scanColor != scanColor;
  }
}
