import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class PaintRander extends StatelessWidget {
  final RTCVideoRenderer videoRenderer;

  const PaintRander({super.key, required this.videoRenderer});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Center(
        child: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: FittedBox(
            clipBehavior: Clip.hardEdge,
            fit: BoxFit.contain,
            child: Center(
                child: ValueListenableBuilder<RTCVideoValue>(
              valueListenable: videoRenderer,
              builder: (context, value, _) {
                return PainterSketchDemo(
                    aspectRatio: value.aspectRatio, constraints: constraints);
              },
              child: Transform(
                transform: Matrix4.identity()..rotateY(0.0),
                alignment: FractionalOffset.center,
                child: Texture(
                  textureId: videoRenderer.textureId!,
                  filterQuality: FilterQuality.low,
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class PainterSketchDemo extends StatefulWidget {
  double aspectRatio;
  BoxConstraints constraints;

  PainterSketchDemo(
      {Key? key, required this.aspectRatio, required this.constraints})
      : super(key: key);

  @override
  _PainterSketchDomeState createState() => new _PainterSketchDomeState();
}

class _PainterSketchDomeState extends State<PainterSketchDemo> {
  List<LinePoints> lines = <LinePoints>[];
  List<Offset> nowPoints = <Offset>[];
  Color nowColor = Colors.redAccent;

  void moveGestureDetector(DragUpdateDetails detail) {
    RenderBox box = context.findRenderObject() as RenderBox;
    final Offset xy = box.globalToLocal(detail.globalPosition); // 重要需要转换以下坐标位置
    Offset p = Offset(xy.dx, xy.dy);
    //Offset p = Offset(detail.globalPosition.dx, detail.globalPosition.dy - 60);
    if (mounted) {
      setState(() {
        nowPoints.add(p);
      });
      print('moveGestureDetector $nowPoints');
    }
  }

  void newGestureDetector(DragStartDetails detail) {
    if (nowPoints.length != 0) {
      LinePoints l = LinePoints(new List<Offset>.from(nowPoints), nowColor);
      lines.add(l);
      nowPoints.clear();
    }
    RenderBox box = context.findRenderObject() as RenderBox;
    final Offset xy = box.globalToLocal(detail.globalPosition); // 重要需要转换以下坐标位置
    Offset p = Offset(xy.dx, xy.dy);
    if (mounted) {
      setState(() {
        nowPoints.add(p);
      });
      print('newGestureDetector $nowPoints');
    }
  }

  void onTapDown(TapDownDetails detail) {}

  void onTapUp(TapUpDetails detail) {
    if (nowPoints.length != 0) {
      LinePoints l = LinePoints(new List<Offset>.from(nowPoints), nowColor);
      lines.add(l);
      nowPoints.clear();
    }
    RenderBox box = context.findRenderObject() as RenderBox;
    final Offset xy = box.globalToLocal(detail.globalPosition); // 重要需要转换以下坐标位置
    Offset p = Offset(xy.dx, xy.dy);
    if (mounted) {
      setState(() {
        nowPoints.add(p);
        nowPoints.add(p);
      });
      print('onTapUp $nowPoints');
    }
  }

  @override
  void didUpdateWidget(covariant PainterSketchDemo oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.aspectRatio != oldWidget.aspectRatio) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: widget.constraints.maxHeight * widget.aspectRatio,
        height: widget.constraints.maxHeight,
        color: const Color.fromRGBO(0, 0, 0, 0),
        // color: Colors.white,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
                child: RepaintBoundary(
              child: AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: GestureDetector(
                  child: CustomPaint(
                    painter: PaintCanvas(lines, nowPoints, nowColor),
                  ),
                  onTapDown: onTapDown,
                  onTapUp: onTapUp,
                  onHorizontalDragUpdate: moveGestureDetector,
                  onVerticalDragUpdate: moveGestureDetector,
                  onHorizontalDragStart: newGestureDetector,
                  onVerticalDragStart: newGestureDetector,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class PaintCanvas extends CustomPainter {
  final List<LinePoints> lines;
  final List<Offset> nowPoints;
  final Color nowColor;

  PaintCanvas(this.lines, this.nowPoints, this.nowColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    canvas.save();
    for (int i = 0; i < lines.length; i++) {
      final LinePoints l = lines[i];
      for (int j = 1; j < l.points.length; j++) {
        final Offset p1 = l.points[j - 1];
        final Offset p2 = l.points[j];
        p.color = l.lineColor;
        canvas.drawLine(p1, p2, p);
      }
    }
    for (int i = 1; i < nowPoints.length; i++) {
      final Offset p1 = nowPoints[i - 1];
      final Offset p2 = nowPoints[i];
      p.color = nowColor;
      canvas.drawLine(p1, p2, p);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LinePoints {
  final List<Offset> points;
  final Color lineColor;

  LinePoints(this.points, this.lineColor);
}

class ColorPallet extends StatelessWidget {
  final Color? color;
  final Function? changeColor;

  const ColorPallet(
      {Key? key, this.color, this.changeColor, this.isSelect = false})
      : super(key: key);
  final bool isSelect;

  void onPressed() {
    changeColor?.call(color);
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints(minWidth: 60.0, minHeight: 50.0),
      child: Container(
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border:
                Border.all(color: Colors.white, width: isSelect ? 3.0 : 0.0)),
      ),
    );
  }
}
