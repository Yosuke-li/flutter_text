import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/banner_demo.dart';
import 'package:flutter_text/assembly_pack/calendar.dart';
import 'package:flutter_text/assembly_pack/chat/chat_main.dart';
import 'package:flutter_text/assembly_pack/curved_bar.dart';
import 'package:flutter_text/assembly_pack/drag_list.dart';
import 'package:flutter_text/assembly_pack/hello.dart';
import 'package:flutter_text/assembly_pack/liquid_text.dart';
import 'package:flutter_text/assembly_pack/local_auth_check.dart';
import 'package:flutter_text/assembly_pack/main.dart';
import 'package:flutter_text/assembly_pack/overlay_demo.dart';
import 'package:flutter_text/assembly_pack/photo.dart';
import 'package:flutter_text/assembly_pack/slidable.dart';
import 'package:flutter_text/assembly_pack/sliding_up_panel.dart';
import 'package:flutter_text/assembly_pack/speed_dial.dart';
import 'package:flutter_text/assembly_pack/translate/translate_page.dart';
import 'package:flutter_text/assembly_pack/video_chat/check_room_id.dart';
import 'package:flutter_text/assembly_pack/video_player/play_local_video.dart';
import 'package:flutter_text/assembly_pack/weather/real_time_page.dart';
import 'assembly_pack/event_bus/event_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_text/assembly_pack/canvas_paint.dart';
import 'package:flutter_text/assembly_pack/stepper.dart';

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

class TabBarDemoful extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  StreamSubscription<PageEvent> eventBus;
  String eventData;
  TabController tabController;
  int currentIndex = 0;

  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1000, height: 2111)..init(context);
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), //禁止滑动
        controller: tabController,
        children: <Widget>[
          ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.chat),
                title: Text(
                  '聊天室--',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => chatPackApp()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.video_call),
                title: Text(
                  '视频通话装置--',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CheckRoomId()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.ondemand_video),
                title: Text(
                  '本地视频播放--',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => videoIndex()),
                  );
                },
              ),
            ],
          ),
          Container(
            child: ListView(
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
                    MaterialPageRoute(
                        builder: (context) => checkBoxListTitle()),
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
                  eventBus =
                      EventBusUtil.getInstance().on<PageEvent>().listen((data) {
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border:
                                  new Border.all(width: 1, color: Colors.grey),
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
                title: Text(
                  'SlidingUpPanel使用',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SlidingUpText()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard),
                title: Text(
                  'liquid使用',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LiquidText()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard),
                title: Text(
                  'canvas',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PainterSketchDome()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard),
                title: Text(
                  'stepper',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StepperDemo()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard),
                title: Text(
                  'photo',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PickImage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard),
                title: Text(
                  'curvedBar',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => curvedBar()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.filter_b_and_w),
                title: Text(
                  'banner组件',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => bannerDemo()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.fingerprint),
                title: Text(
                  'localAuth组件',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LocalAuthCheck()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text(
                  'SpeedDial组件',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SpeedDialDemo()),
                  );
                },
              ),
              ListTile(
                leading:
                    Hero(tag: "calendar", child: Icon(Icons.calendar_today)),
                title: Text(
                  'Calendar组件',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CalendarDemo()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  'simple_animations组件',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Hello()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  '设置',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => overlayDemo()),
                  );
                },
              ),
            ]).toList()),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.chat),
                title: Text(
                  '翻译--',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => translatePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.cloud),
                title: Text(
                  '天 气 预 报',
                  style: TextStyle(
                    fontSize: screenUtil.setSp(40),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RealTimePage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), title: Text('聊天室')),
          BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('组件')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Api')),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          tabController.animateTo(index,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        },
      ),
    );
  }
}
