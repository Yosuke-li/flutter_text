import 'package:flutter/material.dart';

void main() => runApp(AnimatedContainerPage());

class AnimatedContainerPage extends StatefulWidget {
  TextState createState() => TextState();
}

//属性变化
class TextState extends State<AnimatedContainerPage> {
  double width = 50;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedContainer"),
      ),
      body: RepaintBoundary(
        child: GestureDetector(
          onTap: () {
            setState(() {
              width = MediaQuery.of(context).size.width;
            });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 5),
            width: width,
            height: 50,
            color: Colors.red,
            padding: EdgeInsets.only(bottom: 100),
            curve: Curves.bounceOut,
          ),
        ),
      ),
    );
  }
}
