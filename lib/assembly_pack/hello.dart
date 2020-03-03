import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/widget/animated_wave.dart';
import 'package:simple_animations/simple_animations.dart';

void main() => runApp(Hello());

class Hello extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(body: HelloDemo());
  }
}

//scene主场景
class HelloDemo extends StatefulWidget {
  HelloDemoState createState() => HelloDemoState();
}

class HelloDemoState extends State<HelloDemo> {
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]); //清除手机顶部和底部状态栏
  }

  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: LinearBackground()),
        Positioned.fill(
            child: Align(
          alignment: Alignment.topLeft,
          child: Image.asset("images/cloud5.gif",
              width: MediaQuery.of(context).size.width),
        )),
        onWave(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onWave(AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onWave(AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        Positioned.fill(
            child: Center(
          child: Image.asset(
            "images/plane2.gif",
            width: 60,
          ),
        )),
      ],
    );
  }

  onWave(Widget child) => Positioned.fill(
          child: Align(
        alignment: Alignment.bottomCenter,
        child: child,
      ));
}

//背景渐变
class LinearBackground extends StatelessWidget {
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 20),
          ColorTween(begin: Colors.red, end: Colors.blueAccent.shade700)),
      Track("color2").add(Duration(seconds: 20),
          ColorTween(begin: Colors.deepOrange, end: Colors.blue.shade600))
    ]);
    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [animation["color1"], animation["color2"]],
          )),
        );
      },
    );
  }
}
