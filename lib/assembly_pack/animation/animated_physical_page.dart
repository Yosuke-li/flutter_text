import 'package:flutter/material.dart';

class AnimatedPhysicalPage extends StatefulWidget {
  @override
  _AnimatedPhysicalState createState() => _AnimatedPhysicalState();
}

class _AnimatedPhysicalState extends State<AnimatedPhysicalPage> {
  double _elevation = 0.0;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 1)).then(
      (value) {
        if (mounted) {
          return setState(() {
            _elevation = 20.0;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedPhysicalModel(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              gradient: LinearGradient(
                colors: <Color>[Colors.blue, Colors.blue.shade300],
              ),
            ),
          ),
          duration: const Duration(seconds: 1),
          animateColor: true,
          animateShadowColor: true,
          elevation: _elevation,
          shape: BoxShape.circle,
          shadowColor: Colors.blue.shade300,
          curve: Curves.easeInOutCubic,
          color: Colors.blue,
        ),
      ),
    );
  }
}
