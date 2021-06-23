import 'package:flutter/material.dart';

class SudoWidget extends StatefulWidget {

  @override
  _SudoState createState() => _SudoState();
}

class _SudoState extends State<SudoWidget> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          _checkerboardWidget(),
        ],
      ),
    );
  }

  Widget _checkerboardWidget() {
    return Container();
  }

  Widget _checkerboardControl() {
    return Container();
  }
}