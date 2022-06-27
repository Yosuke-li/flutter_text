import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../init.dart';

class Npc extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  Npc({
    this.src = 'human/F_01.png',
    this.joystick,
  }) : super(
          size: Vector2(32, 32),
          anchor: Anchor.center,
        );

  final String src;
  late SpriteSheet sheet;
  List<Sprite> sprites = [];
  final JoystickComponent? joystick;

  double maxSpeed = 1;

  @override
  Future<void> onLoad() async {
    await gameRef.images.load(src);
    var image = gameRef.images.fromCache(src);
    sheet = SpriteSheet.fromColumnsAndRows(image: image, columns: 4, rows: 3);

    /// 048 159 2610 3711
    sprites = [
      sheet.getSpriteById(0),
    ];
    animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 8,
      loop: false,
    );
    position = gameRef.size / 3;
    animation!.onComplete = _onLastFrame;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick!.delta.isZero() && activeCollisions.isEmpty) {
      if (joystick!.direction == JoystickDirection.left ||
          joystick!.direction == JoystickDirection.right ||
          joystick!.direction == JoystickDirection.up ||
          joystick!.direction == JoystickDirection.down) {
        move(joystick!.delta * maxSpeed * 0.3);
      }
    }
  }

  void _onLastFrame() {
    animation!.currentIndex = 0;
    animation!.update(0);
  }

  void move(Vector2 ds) {
    if (ds.x > 0) {
      sprites = [
        sheet.getSpriteById(1),
        sheet.getSpriteById(5),
        sheet.getSpriteById(9),
        sheet.getSpriteById(1),
      ];
    } else if (ds.x < 0) {
      sprites = [
        sheet.getSpriteById(3),
        sheet.getSpriteById(7),
        sheet.getSpriteById(11),
        sheet.getSpriteById(3),
      ];
    } else if (ds.y > 0) {
      sprites = [
        sheet.getSpriteById(0),
        sheet.getSpriteById(4),
        sheet.getSpriteById(8),
        sheet.getSpriteById(0),
      ];
    } else if (ds.y < 0) {
      sprites = [
        sheet.getSpriteById(2),
        sheet.getSpriteById(6),
        sheet.getSpriteById(10),
        sheet.getSpriteById(2),
      ];
    }
    animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 1 / 15,
      loop: false,
    );
    position.add(ds);
    animation!.onComplete = _onLastFrame;
  }
}
