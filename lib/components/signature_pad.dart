import 'package:flutter/material.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({
    Key? key,
    this.width = 300,
    this.height = 400,
    this.strokeWidth = 2.0,
    this.strokeColor = Colors.black,
    this.backgroundColor = Colors.white,
    required this.onSave,
  }) : super(key: key);

  final double width;
  final double height;
  final double strokeWidth;
  final Color strokeColor;
  final Color backgroundColor;
  final Function(List<Offset>) onSave;

  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: Border.all(color: Colors.grey),
          ),
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                _points = [..._points, localPosition];
              });
            },
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                _points = [..._points, localPosition];
              });
            },
            onPanEnd: (DragEndDetails details) {
              _points = [..._points, Offset.infinite];
            },
            child: CustomPaint(
              painter: SignaturePainter(
                points: _points,
                strokeWidth: widget.strokeWidth,
                strokeColor: widget.strokeColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _points.clear();
                });
              },
              child: Text('清除'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_points);
              },
              child: Text('保存'),
            ),
          ],
        ),
      ],
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset> points;
  final double strokeWidth;
  final Color strokeColor;

  SignaturePainter({
    required this.points,
    required this.strokeWidth,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.infinite && points[i + 1] != Offset.infinite) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}