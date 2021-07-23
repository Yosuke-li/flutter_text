import 'dart:io';

import 'package:flutter/material.dart';

import 'keyboard_controller.dart';
import 'keyboard_manager.dart';

typedef KeyboardSwitch = Function(SecurityKeyboardType type);

enum SecurityKeyboardType { text, number }

extension SecurityKeyboardTypeTxt on SecurityKeyboardType {
  String get enumToString {
    switch (this) {
      case SecurityKeyboardType.number:
        return 'SecurityKeyboardTypeNumber';
        break;
      case SecurityKeyboardType.text:
        return 'SecurityKeyboardTypeText';
        break;
      default:
        return null;
    }
  }
}

class SecurityKeyboard extends StatelessWidget {
  static SecurityTextInputType number =
      SecurityTextInputType(name: SecurityKeyboardType.number.enumToString);

  static double getHeight(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return mediaQuery.size.width / 3 / 2 * 4;
  }

  final KeyboardController controller;

  const SecurityKeyboard({@required this.controller});

  static void register() {
    KeyboardManager.addKeyboard(
        SecurityKeyboard.number,
        KeyboardConfig(
            builder: (context, controller, params) {
              return SecurityKeyboard(controller: controller);
            },
            getHeight: SecurityKeyboard.getHeight));
  }

  @override
  Widget build(BuildContext context) {
    Widget keyboard;
    keyboard = DefaultTextStyle(
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 23.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 3 / 2 * 2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xffafafaf),
          ),
          child: GridView.count(
              childAspectRatio: 2 / 1,
              mainAxisSpacing: 0.5,
              crossAxisSpacing: 0.5,
              padding: const EdgeInsets.all(0.0),
              crossAxisCount: 3,
              children: <Widget>[
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                Container(
                  color: const Color(0xFFd3d6dd),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: const Center(
                      child: Icon(Icons.expand_more),
                    ),
                    onTap: () {
                      controller.doneAction();
                    },
                  ),
                ),
                buildButton('0'),
                Container(
                  color: const Color(0xFFd3d6dd),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: const Center(
                      child: Text('X'),
                    ),
                    onTap: () {
                      controller.deleteOne();
                    },
                  ),
                ),
              ]),
        ));

    return keyboard;
  }

  Widget buildButton(String title, {String value}) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(title),
        ),
        onTap: () {
          controller.addText(value ?? title);
        },
      ),
    );
  }
}
