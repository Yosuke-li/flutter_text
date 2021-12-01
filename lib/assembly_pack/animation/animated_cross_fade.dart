import 'package:flutter/material.dart';

void main() => runApp(AnimatedCrossFadePage());

class AnimatedCrossFadePage extends StatefulWidget {
  @override
  TextState createState() => TextState();
}

//属性变化
class TextState extends State<AnimatedCrossFadePage> {
  double width = 50;
  bool _first = true;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 1)).then(
      (value) => setState(() {
        _first = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFade'),
      ),
      body: AnimatedCrossFade(
        firstChild: Container(
          width: 50,
          height: 50,
          color: Colors.red,
        ),
        secondChild: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
        crossFadeState:
            _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
