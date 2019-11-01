import 'package:flutter/material.dart';

void main() => runApp(new decoratedBox());

class decoratedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'slider Study',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Decorated Box 组件'),
        ),
        body: Center(
          child: contextPage(),
        ),
      ),
    );
  }
}

class contextPage extends StatefulWidget  {

  @override
  State<StatefulWidget> createState() => contextPageState();

}

class contextPageState extends State<contextPage> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Text('Hello layoutRow'),
    );
  }
}

