import 'package:flutter/material.dart';
import 'package:self_utils/utils/log_utils.dart';

class PaintExampleOne extends StatefulWidget {
  const PaintExampleOne({Key? key}) : super(key: key);

  @override
  State<PaintExampleOne> createState() => _PaintExampleOneState();
}

class _PaintExampleOneState extends State<PaintExampleOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _controller.addListener(() {
      // setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///repaint的用法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        child: CustomPaint(
          size: const Size(200, 200),
          painter: _CustomPaintEx(factor: _controller),
        ),
      ),
    );
  }
}

class _CustomPaintEx extends CustomPainter {
  final Animation<double> factor;

  /// repaint刷新[CustomPainter]
  _CustomPaintEx({required this.factor}):super(repaint: factor);

  @override
  void paint(Canvas canvas, Size size) {
    Log.info('$hashCode'); //使用repaint并不会更新组件的hashcode，说明组件没变，但动画效果还是出来了
    Paint paint = Paint()
      ..color = Color.lerp(Colors.red, Colors.blue, factor.value)!;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
