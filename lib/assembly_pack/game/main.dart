import 'package:flame/game.dart';
import 'package:flutter/services.dart';

import '../../init.dart';
import 'example.dart';

class TankMainPage extends StatefulWidget {
  const TankMainPage({Key? key}) : super(key: key);

  @override
  State<TankMainPage> createState() => _TankMainPageState();
}

class _TankMainPageState extends State<TankMainPage> {

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: JoystickExample());
  }
}
