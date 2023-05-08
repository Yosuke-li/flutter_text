import 'package:flutter/material.dart';

class PaintExampleTwo extends StatefulWidget {
  const PaintExampleTwo({Key? key}) : super(key: key);

  @override
  State<PaintExampleTwo> createState() => _PaintExampleTwoState();
}

class _PaintExampleTwoState extends State<PaintExampleTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: _PaintEx(),
        ),
      ),
    );
  }
}


class _PaintEx extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final Size center = size / 2;
    final Paint paint = Paint()..color = Colors.red;
    Path path = Path();
    path.moveTo(center.width - 30, 100);
    path.lineTo(center.width + 30, 100);
    path.lineTo(center.width, 150);
    path.lineTo(center.width - 30, 100);
    // canvas.drawRect(Rect.fromLTWH(center.width - 100, 60, 200, 120), paint);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}