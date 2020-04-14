import 'package:flutter/material.dart';

void main() => runApp(AnimatedCrossFadePage());

class AnimatedCrossFadePage extends StatefulWidget {
  TextState createState() => TextState();
}

//属性变化
class TextState extends State<AnimatedCrossFadePage> {
  double width = 50;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedCrossFade"),
      ),
      body: AnimatedCrossFade(
        firstChild: Container(),
        secondChild: Container(),

      ),
    );
  }
}
