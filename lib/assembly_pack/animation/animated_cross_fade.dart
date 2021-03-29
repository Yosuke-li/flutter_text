import 'package:flutter/material.dart';

void main() => runApp(AnimatedCrossFadePage());

class AnimatedCrossFadePage extends StatefulWidget {
  @override
  TextState createState() => TextState();
}

//属性变化
class TextState extends State<AnimatedCrossFadePage> {
  double width = 50;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFade'),
      ),
      body: AnimatedCrossFade(
        firstChild: Container(),
        secondChild: Container(),
        crossFadeState: null,
        duration: null,
      ),
    );
  }
}
