import 'package:flame/components.dart';

import '../../init.dart';

mixin LifeAble on PositionComponent {
  final Paint _outlinePaint = Paint();
  final Paint _fillPaint = Paint();
  late double lifePoint; // 生命上限
  late double _currentLife; // 当前生命值

  void initPaint({
    required double lifePoint,
    Color lifeColor = Colors.red,
    Color outlineColor = Colors.white,
  }) {
    _outlinePaint
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    _fillPaint.color = lifeColor;

    this.lifePoint = lifePoint;
    _currentLife = lifePoint;
  }

  // 当前血条百分百
  double get _progress => _currentLife / lifePoint;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final double offsetY = 11; // 血条距构件顶部偏移量
    final double widthRadio = 1.5; // 血条/构件宽度
    final double lifeBarHeight = 5; // 血条高度

    Rect rect = Rect.fromCenter(
        center: Offset(size.x / 2, lifeBarHeight / 2 - offsetY),
        width: size.x / 2 * widthRadio,
        height: lifeBarHeight);

    Rect lifeRect = Rect.fromPoints(
        rect.topLeft + Offset(rect.width * (1 - _progress), 0),
        rect.bottomRight);

    canvas.drawRect(lifeRect, _fillPaint);
    canvas.drawRect(rect, _outlinePaint);
  }

  void loss(double point) {
    _currentLife -= point;
    if (_currentLife <= 0) {
      _currentLife = 0;
      onDied();
    }
  }

  void onDied() {

  }
}