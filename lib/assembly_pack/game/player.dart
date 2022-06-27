import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/effects.dart';
import 'package:flutter_text/assembly_pack/game/life.dart';
import 'package:flutter_text/init.dart';

class JoystickPlayer extends SpriteComponent
    with HasGameRef, CollisionCallbacks, LifeAble {
  /// Pixels/s
  double maxSpeed = 300.0;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();
  late JoystickDirection currentDirection = JoystickDirection.right;

  final JoystickComponent joystick;

  JoystickPlayer(this.joystick)
      : super(size: Vector2.all(100.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    initPaint(lifePoint: 1000);
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 2;

    add(RectangleHitbox());
  }

  @override
  void onDied() {
    removeFromParent();
  }

  /// player.flipHorizontally 切换左右
  @override
  void update(double dt) {
    if (!joystick.delta.isZero() && activeCollisions.isEmpty) {
      _lastSize.setFrom(size);
      _lastTransform.setFrom(transform);
      position.add(joystick.relativeDelta * maxSpeed * dt);
      if (joystick.direction != currentDirection ) {
        flipHorizontally();
        currentDirection = joystick.direction;
      }
    }
  }

  @override
  void onCollisionStart(Set<Vector2> _, PositionComponent __) {
    super.onCollisionStart(_, __);
    transform.setFrom(_lastTransform);
    size.setFrom(_lastSize);
  }

  @override
  void onCollisionEnd(PositionComponent __) {
    super.onCollisionEnd(__);
  }

  void move(Vector2 ds){
    position.add(ds);
  }

  void flip({
    bool x = false,
    bool y = true,
  }) {
    scale = Vector2(scale.x * (y ? -1 : 1), scale.y * (x ? -1 : 1));
  }
}