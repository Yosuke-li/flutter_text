import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/assembly_pack/game/npc.dart';
import 'package:flutter_text/assembly_pack/game/player.dart';
import 'package:flutter_text/init.dart';

import 'map.dart';

class JoystickExample extends FlameGame with KeyboardEvents {
  late final JoystickPlayer player;
  late final Npc npc;
  final GameMap map = GameMap();
  late final JoystickComponent joystick;

  final double step = 20;

  @override
  Future<void> onLoad() async {
    final Paint knobPaint = BasicPalette.white.withAlpha(200).paint();
    final Paint backgroundPaint = BasicPalette.white.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 25, paint: knobPaint),
      background: CircleComponent(radius: 60, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    npc = Npc(src: 'human/F_01.png', joystick: joystick);

    // camera.viewport = FixedResolutionViewport(
    //   Vector2(1280, 800),
    // );
    add(map);
    // camera.speed = 1;
    // camera.followComponent(npc, worldBounds: GameMap.bounds);

    add(npc);
    add(joystick);
  }

  ///
  ///  键盘事件
  // @override
  // KeyEventResult onKeyEvent(
  //   RawKeyEvent event,
  //   Set<LogicalKeyboardKey> keysPressed,
  // ) {
  //   final isKeyDown = event is RawKeyDownEvent;
  //   if (event.logicalKey == LogicalKeyboardKey.keyY && isKeyDown) {
  //     player.flip(y: true);
  //   }
  //   if (event.logicalKey == LogicalKeyboardKey.keyX && isKeyDown) {
  //     player.flip(x: true);
  //   }
  //
  //   if (event.logicalKey == LogicalKeyboardKey.keyQ) {
  //     player.loss(10);
  //   }
  //
  //   if ((event.logicalKey == LogicalKeyboardKey.arrowUp ||
  //           event.logicalKey == LogicalKeyboardKey.keyW) &&
  //       isKeyDown) {
  //     npc.move(Vector2(0, -step));
  //   }
  //   if ((event.logicalKey == LogicalKeyboardKey.arrowDown ||
  //           event.logicalKey == LogicalKeyboardKey.keyS) &&
  //       isKeyDown) {
  //     npc.move(Vector2(0, step));
  //   }
  //   if ((event.logicalKey == LogicalKeyboardKey.arrowLeft ||
  //           event.logicalKey == LogicalKeyboardKey.keyA) &&
  //       isKeyDown) {
  //     npc.move(Vector2(-step, 0));
  //   }
  //   if ((event.logicalKey == LogicalKeyboardKey.arrowRight ||
  //           event.logicalKey == LogicalKeyboardKey.keyD) &&
  //       isKeyDown) {
  //     npc.move(Vector2(step, 0));
  //   }
  //   return super.onKeyEvent(event, keysPressed);
  // }
}
