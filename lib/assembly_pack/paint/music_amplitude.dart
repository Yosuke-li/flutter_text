import 'dart:math';

import 'package:flutter/material.dart';

class MusicAmplitude extends StatefulWidget {
  const MusicAmplitude({Key? key}) : super(key: key);

  @override
  State<MusicAmplitude> createState() => _MusicAmplitudeState();
}

class _MusicAmplitudeState extends State<MusicAmplitude> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<double> _list;

  @override
  void initState() {
    super.initState();
    final ran = Random();
    _list = [
      ran.nextDouble(),
      ran.nextDouble(),
      ran.nextDouble(),
      ran.nextDouble(),
      ran.nextDouble(),
    ];
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    controller.addStatusListener((status) {
      //动画结束后反转
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      //反转后重置随机值，继续播放
      if (status == AnimationStatus.dismissed) {
        final ran =  Random();
        _list = [
          ran.nextDouble(),
          ran.nextDouble(),
          ran.nextDouble(),
          ran.nextDouble(),
          ran.nextDouble(),
        ];
        setState(() {});
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: const Size(20, 20),
        painter: _Painter(controller, _list),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final Animation<double> controller;
  double sizeWidth = 20;
  final List<double> _list;

  _Painter(this.controller, this._list) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3;
    final Shader shader = const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        tileMode: TileMode.clamp,
        colors: [Colors.red, Colors.amber])
        .createShader(const Rect.fromLTRB(0, 0, 30, 30));
    paint.shader = shader;

    //平移到左下角
    canvas.translate(0, size.height);

    //画5根线
    canvas.drawLine(
        Offset(0, 0), Offset(0, -sizeWidth * (controller.value) * _list[0]), paint);
    canvas.drawLine(
        Offset(5, 0),
        Offset(5, -sizeWidth * (controller.value) * _list[1] * _list[3] - 4),
        paint);
    canvas.drawLine(Offset(10, 0),
        Offset(10, -sizeWidth * (controller.value) * _list[2] - 1), paint);
    canvas.drawLine(
        Offset(15, 0),
        Offset(15, -sizeWidth * (controller.value) * _list[3] * _list[1] - 2),
        paint);
    canvas.drawLine(Offset(20, 0),
        Offset(20, -sizeWidth * (controller.value) * _list[4] - 3), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

}
