import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/main.dart';

import 'assembly_pack/slider.dart';
import 'assembly_pack/layout_row.dart';
import 'assembly_pack/decorated_box.dart';
import 'assembly_pack/text_field.dart';
import 'assembly_pack/check_box_list_title.dart';
import 'assembly_pack/gridview.dart';
import 'assembly_pack/raised_button.dart';
import 'assembly_pack/flexible_space_bar.dart';

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
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (BuildContext context) => textField()),
                  ).then((onValue) {
                    print('返回回来的手机号是：'+ onValue);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('checkBox组件'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => checkBoxListTitle()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.grid_on),
                title: Text('GridView组件'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => gridView()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.bug_report),
                title: Text('RaisedButton组件'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => raisedButton()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.space_bar),
                title: Text('FlexibleSpaceBar组件(折叠)'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => flexibleSpaceBar()),
                  );
                },
              ),
            ]
        ).toList()
      ),
    );
  }
}