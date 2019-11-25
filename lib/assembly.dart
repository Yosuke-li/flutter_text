import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/drag_list.dart';
import 'package:flutter_text/assembly_pack/main.dart';
import 'package:flutter_text/assembly_pack/slidable.dart';
import 'package:flutter_text/assembly_pack/sliding_up_panel.dart';
import 'assembly_pack/event_bus/event_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'assembly_pack/slider.dart';
import 'assembly_pack/layout_row.dart';
import 'assembly_pack/decorated_box.dart';
import 'assembly_pack/text_field.dart';
import 'assembly_pack/check_box_list_title.dart';
import 'assembly_pack/gridview.dart';
import 'assembly_pack/raised_button.dart';
import 'assembly_pack/flexible_space_bar.dart';
import 'assembly_pack/event_bus/first_page.dart';
import 'assembly_pack/layout_demo.dart';
import 'assembly_pack/bottom_bar.dart';
import 'assembly_pack/popup_menu.dart';
import 'assembly_pack/form_text.dart';

void main() => runApp(new assembly());

class assembly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Study',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('组件列表'),
        ),
        body: Center(
          child: TabBarDemo(),
        ),
      ),
    );
  }
}

class TabBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabBarDemoful();
}

class TabBarDemoful extends State<TabBarDemo> {
  StreamSubscription<PageEvent> eventBus;
  String eventData;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1000, height: 2111)..init(context);
    ScreenUtil screenUtil = ScreenUtil();
    return ListView(
        children: ListTile.divideTiles(context: context, tiles: [
      ListTile(
        leading: Icon(Icons.fastfood),
        title: Text(
          '美食列表',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.swap_horizontal_circle),
        title: Text(
          '滑块组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => slider()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.format_line_spacing),
        title: Text(
          '水平布局',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => layoutRow()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.inbox),
        title: Text(
          '装饰容器',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => decoratedBox()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.input),
        title: Text(
          '文本输入框',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => textField()),
          ).then((onValue) {
            print('返回回来的手机号是：' + onValue);
          });
        },
      ),
      ListTile(
        leading: Icon(Icons.check_box),
        title: Text(
          'checkBox组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => checkBoxListTitle()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.grid_on),
        title: Text(
          'GridView组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => gridView()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.bug_report),
        title: Text(
          'RaisedButton组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => raisedButton()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.space_bar),
        title: Text(
          'FlexibleSpaceBar组件(折叠)',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => flexibleSpaceBar()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.text_fields),
        title: Text(
          'eventData的值为：${eventData}',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          eventBus = EventBusUtil.getInstance().on<PageEvent>().listen((data) {
            setState(() {
              eventData = data.test;
            });
            print('onTap打印eventData：${eventData}');
            eventBus.cancel();
          });
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return Center(
                  child: Container(
                    width: 350,
                    height: 100,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: new Border.all(width: 1, color: Colors.grey),
                    ),
                    child: EventBusDemo(),
                  ),
                );
              }));
        },
      ),
      ListTile(
        leading: Icon(Icons.receipt),
        title: Text(
          'Layout抽屉组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LayoutDemo()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.local_bar),
        title: Text(
          '底部导航栏组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => bottomBar()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.more_vert),
        title: Text(
          'PopupMenu组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PopupMenu()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.format_align_center),
        title: Text(
          'Form组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FormText()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.format_align_justify),
        title: Text(
          'Drag_list组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DragText()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.input),
        title: Text(
          'Slidable组件',
          style: TextStyle(
            fontSize: screenUtil.setSp(40),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SlidableText()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.keyboard),
        title: Text('SlidingUpPanel使用'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SlidingUpText()),
          );
        },
      )
    ]).toList());
  }
}
