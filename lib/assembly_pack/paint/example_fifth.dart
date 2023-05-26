import 'dart:math';

import 'package:flutter_text/assembly_pack/paint/mock.dart';

import '../../init.dart';
import 'dash.dart';
import 'line.dart';

class ExampleFifthPage extends StatefulWidget {
  const ExampleFifthPage({Key? key}) : super(key: key);

  @override
  State<ExampleFifthPage> createState() => _ExampleFifthPageState();
}

class _ExampleFifthPageState extends State<ExampleFifthPage> {
  Offset? click = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapDown: (c) {
            click = c.localPosition;
            Log.info(click!);
            setState(() {});
          },
          onTapUp: (c) {
            click = Offset.zero;
            setState(() {});
          },
          child: Container(
            color: Colors.black12,
            child: RepaintBoundary(
              child: CustomPaint(
                size: const Size(300, 300),
                painter: _PaintEx(
                  center: Offset(150, 150),
                  innerRadius: 40,
                  outRadius: 80,
                  startAngle: 30 * pi / 180,
                  sweepAngle: -80 * pi / 180,
                  click: click,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PaintEx extends CustomPainter {
  Offset center; // 中心点
  double innerRadius; // 小圆半径
  double outRadius; // 大圆半径
  double startAngle; // 起始弧度
  double sweepAngle; // 扫描弧度

  Offset? click; //点击区域

  _PaintEx({
    required this.center,
    required this.innerRadius,
    required this.outRadius,
    required this.startAngle,
    required this.sweepAngle,
    this.click,
  });

  Muses muses = Muses();
  DashPainter dashPainter = const DashPainter();

  @override
  void paint(Canvas canvas, Size size) {
    muses.attach(canvas);
    double end = startAngle + sweepAngle;
    Offset p0 =
        Offset(cos(startAngle) * innerRadius, sin(startAngle) * innerRadius);
    Offset p1 =
        Offset(cos(startAngle) * outRadius, sin(startAngle) * outRadius);
    Offset q0 = Offset(cos(end) * innerRadius, sin(end) * innerRadius);
    Offset q1 = Offset(cos(end) * outRadius, sin(end) * outRadius);

    bool large = sweepAngle.abs() > pi;
    bool clockwise = sweepAngle > 0;

    Path path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..arcToPoint(q1,
          radius: Radius.circular(outRadius),
          clockwise: clockwise,
          largeArc: large)
      ..lineTo(q0.dx, q0.dy)
      ..arcToPoint(p0,
          radius: Radius.circular(innerRadius),
          clockwise: !clockwise,
          largeArc: large);

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.blue;

    bool inSide = contains(click!);
    if (inSide) {
      canvas.drawPath(path.shift(center), paint);
      Paint paint2 = Paint()..style = PaintingStyle.stroke;
      canvas.drawPath(path.shift(center), paint2);
    }
    //辅助线
    canvas.translate(size.width / 2, size.height / 2);
    muses.markCircle(Offset.zero, 80);
    muses.markCircle(Offset.zero, 40);
    muses.markLine(Line.fromRad(start: Offset.zero, rad: startAngle, len: 80));
    muses.markLine(Line.fromRad(start:  Offset.zero, rad: startAngle + sweepAngle, len: 80));
  }

  bool contains(Offset p) {
    // 校验环形区域
    double l = (p - center).distance;
    bool inRing = l <= outRadius && l >= innerRadius;
    if (!inRing) return false;

    // 校验角度范围
    double a = (p - center).direction;
    double endArg = startAngle + sweepAngle;
    double start = startAngle;
    if (sweepAngle > 0) {
      return a >= start && a <= endArg;
    } else {
      return a <= start && a >= endArg;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
