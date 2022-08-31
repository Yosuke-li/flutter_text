import 'package:flutter/material.dart';
import 'package:self_utils/widget/keyboard_action/content.dart';

class KeyboardPage extends StatefulWidget {
  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<KeyboardPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyboard Actions Sample'),
      ),
      body: Content(),
    );
  }
}