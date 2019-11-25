import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(SlidingUpText());

class SlidingUpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SlidingUpPanel组件'),
      ),
      body: SlidingUpPanel(
        panel: Center(
          child: Text('抽屉区'),
        ),
        body: Center(
          child: Text('页面区'),
        ),
      ),
    );
  }
}
