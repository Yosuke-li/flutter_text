import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_text/init.dart';

class PaintExampleThr extends StatefulWidget {
  const PaintExampleThr({Key? key}) : super(key: key);

  @override
  State<PaintExampleThr> createState() => _PaintExampleThrState();
}

class _PaintExampleThrState extends State<PaintExampleThr>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Log.info('_controller is completed');
        _controller.repeat();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        CustomPaint(
          size: const Size(400, 200),
          painter: _PaintEx(
              value: Tween<double>(begin: 0.0, end: 1.0).animate(_controller)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.isAnimating) {
              _controller.stop();
            } else {
              _controller.forward();
            }
            setState(() {});
          },
          child: Text('${_controller.isAnimating ? 'stop' : 'forward'}'),
        ),
      ],
    ));
  }
}

class _PaintEx extends CustomPainter {
  List<double> xAxis = [0, 50, 100, 150, 200, 250, 300, 350, 400];
  Animation<double> value;

  _PaintEx({required this.value}) : super(repaint: value);

  @override
  void paint(Canvas canvas, Size size) {
    // Log.info(hashCode);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 3;
    final Path path = Path();
    canvas.translate(0, size.height / 2);
    for (int i = 0; i < xAxis.length - 1; i++) {
      double x1 = xAxis[i];
      double y1 = funSquare(x1);
      double x2 = (xAxis[i] + xAxis[i + 1]) / 2;
      double y2 = (y1 + funSquare(xAxis[i + 1])) / 2;
      path.quadraticBezierTo(x1, y1, x2, y2);
    }
    canvas.drawPath(path, paint);
  }

  double funSquare(double x) {
    final double p = 100 *
        sin(((4 * pi * x) / 400) - 100 * value.value) *
        sin((x * pi) / 400);
    return p;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
