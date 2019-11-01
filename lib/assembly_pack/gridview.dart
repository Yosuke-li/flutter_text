import 'package:flutter/material.dart';

void main() => runApp(new gridView());

class gridView extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'slider Study',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('layoutRow 组件'),
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
      child: _buildGridCustom(),
    );
  }

  //SliverGridDelegateWithFixedCrossAxisCount可以指定列的个数的Grid
  //SliverGridDelegateWithMaxCrossAxisExtent根据每个宽度自动计算的Grid
  Widget _buildGridCustom() {
    return GridView.custom(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              return Image.asset('images/timg3.jpg');
            },
            childCount: 10
        ),
    );
  }

}

