import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/main.dart';

import 'assembly_pack/slider.dart';
import 'assembly_pack/layout_row.dart';
import 'assembly_pack/decoratedBox.dart';
import 'assembly_pack/text_field.dart';

void main() => runApp(new assembly());

class assembly extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Study',
      home: TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text( '组件列表'),
      ),
      body: new ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                leading: Icon(Icons.fastfood),
                title: Text('美食列表'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.swap_horizontal_circle),
                title: Text('滑块组件'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => slider()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.format_line_spacing),
                title: Text('水平布局'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => layoutRow()),
                    );
                },
              ),
              ListTile(
                leading: Icon(Icons.inbox),
                title: Text('装饰容器'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => decoratedBox()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.input),
                title: Text('文本输入框'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => textField()),
                  );
                },
              )
            ]
        ).toList()
      ),
    );
  }
}