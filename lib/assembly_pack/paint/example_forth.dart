import 'dart:math';

import 'package:flutter_text/init.dart';
import 'board.dart';

enum GameStatus { finish, stop, playing }

class PaintExampleForth extends StatefulWidget {
  const PaintExampleForth({Key? key}) : super(key: key);

  @override
  State<PaintExampleForth> createState() => _PaintExampleForthState();
}

class _PaintExampleForthState extends State<PaintExampleForth> with Board {
  List<List<int>> points = [];

  int step = 0; //步数
  GameStatus status = GameStatus.stop;
  Size boxSize = const Size(300, 300);

  @override
  void initState() {
    super.initState();
    init(col: 15);
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
                    if (status == GameStatus.finish) {
                      step = 0;
                      points.clear();
                      board.clear();
                      init(col: 15);
                    }
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
                    board[point[1]][point[0]] = 1;
                    check = checkWin(point[1], point[0], 1);
                  } else {
                    board[point[1]][point[0]] = 2;
                    check = checkWin(point[1], point[0], 2);
                  }
                  if (check) {
                    ToastUtils.showToast(msg: '游戏结束！${step % 2 == 0 ? '黑子' : '白子'}获胜！');
                    status = GameStatus.finish;
                  }
                  step++;
                  setState(() {});
                }
              },
              child: RepaintBoundary(
                child: CustomPaint(
                  size: boxSize,
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
    final int x = ((tap.dx / boxSize.width) * 15).round();
    final int y = ((tap.dy / boxSize.height) * 15).round();
    return <int>[x, y];
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
