import 'dart:math';

import 'package:flutter_text/init.dart';

enum GameStatus { finish, stop, playing }

class PaintExampleForth extends StatefulWidget {
  const PaintExampleForth({Key? key}) : super(key: key);

  @override
  State<PaintExampleForth> createState() => _PaintExampleForthState();
}

class _PaintExampleForthState extends State<PaintExampleForth> {
  List<List<int>> points = [];

  final List<List<int>> black = [];
  final List<List<int>> white = [];
  int step = 0; //步数
  GameStatus status = GameStatus.stop;
  Size size = const Size(300, 300);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (status != GameStatus.playing) {
                      status = GameStatus.playing;
                    } else {
                      status = GameStatus.stop;
                    }
                    setState(() {});
                  },
                  child: Text(
                    '${status != GameStatus.playing ? 'Game Start !' : 'Stop'}',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTapUp: (detail) {
                if (status != GameStatus.playing) {
                  return;
                }
                final List<int> point = _setCanvasSet(detail.localPosition);
                bool check = false;
                if (points.any((e) => e[0] == point[0] && e[1] == point[1])) {
                  return;
                } else {
                  points.add(point);
                  if (step % 2 == 0) {
                    black.add(point);
                    check = checkWin(black);
                  } else {
                    white.add(point);
                    check = checkWin(white);
                  }
                  step++;
                  if (check) {
                    status = GameStatus.finish;
                  }
                  setState(() {});
                }
              },
              child: RepaintBoundary(
                child: CustomPaint(
                  size: size,
                  painter: _PaintEx(points: points),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<int> _setCanvasSet(Offset tap) {
    final int x = ((tap.dx / size.width) * 15).round();
    final int y = ((tap.dy / size.height) * 15).round();
    return <int>[x, y];
  }

  // 检查胜利条件
  bool checkWin(List<List<int>> points) {
    for (int i = 0; i < points.length; i++) {
      final counts = <String, int>{};
      for (int j = 0; j < points.length; j++) {
        if (i == j) continue;
        final x1 = points[i][0];
        final y1 = points[i][1];
        final x2 = points[j][0];
        final y2 = points[j][1];
        final k = (x2 == x1) ? double.infinity : (y2 - y1) / (x2 - x1);
        final b = y1 - k * x1;
        final key = '$k,$b';
        if (counts.containsKey(key)) {
          counts[key] = counts[key]! + 1;
        } else {
          counts[key] = 1;
        }
      }
      if (counts.values.any((int count) => count >= 4)) {
        ToastUtils.showToast(msg: '游戏结束，${step % 2 == 0 ? '黑子' : '白子'}获胜！');
        return true;
      }
    }
    return false;
  }
}

class _PaintEx extends CustomPainter {
  List<List<int>> points = [];

  _PaintEx({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = const Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    for (int i = 0; i < points.length; i++) {
      final List<int> point = points[i];
      paint
        ..style = PaintingStyle.fill
        ..color = i % 2 == 0 ? Colors.black : Colors.white;
      canvas.drawCircle(
        Offset(eWidth * point[0], eHeight * point[1]),
        min(eWidth / 2, eHeight / 2) - 2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

