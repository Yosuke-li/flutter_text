import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/animation/component.dart';
import 'package:flutter_text/assembly_pack/banner_demo.dart';
import 'package:flutter_text/assembly_pack/calendar/calendar.dart';
import 'package:flutter_text/assembly_pack/calendar/mini_calendar.dart';
import 'package:flutter_text/assembly_pack/chat/chat_main.dart';
import 'package:flutter_text/assembly_pack/connected/connect_data.dart';
import 'package:flutter_text/assembly_pack/curved_bar.dart';
import 'package:flutter_text/assembly_pack/db_register/register.dart';
import 'package:flutter_text/assembly_pack/drag_list.dart';
import 'package:flutter_text/assembly_pack/flutter_picker.dart';
import 'package:flutter_text/assembly_pack/hello.dart';
import 'package:flutter_text/assembly_pack/liquid_text.dart';
import 'package:flutter_text/assembly_pack/local_auth_check.dart';
import 'package:flutter_text/assembly_pack/login/login_video_page.dart';
import 'package:flutter_text/assembly_pack/main.dart';
import 'package:flutter_text/assembly_pack/mic_stream_demo.dart';
import 'package:flutter_text/assembly_pack/overlay_demo.dart';
import 'package:flutter_text/assembly_pack/pdf.dart';
import 'package:flutter_text/assembly_pack/pdf_read.dart';
import 'package:flutter_text/assembly_pack/pear_video/pear_video.dart';
import 'package:flutter_text/assembly_pack/photo.dart';
import 'package:flutter_text/assembly_pack/save_text/save_text.dart';
import 'package:flutter_text/assembly_pack/scan_book/scan_book.dart';
import 'package:flutter_text/assembly_pack/scheme_text.dart';
import 'package:flutter_text/assembly_pack/slidable.dart';
import 'package:flutter_text/assembly_pack/sliding_up_panel.dart';
import 'package:flutter_text/assembly_pack/speed_dial.dart';
import 'package:flutter_text/assembly_pack/storage_test.dart';
import 'package:flutter_text/assembly_pack/translate/translate_page.dart';
import 'package:flutter_text/assembly_pack/video_chat/check_room_id.dart';
import 'package:flutter_text/assembly_pack/video_player/play_local_video.dart';
import 'package:flutter_text/assembly_pack/video_player/video_list.dart';
import 'package:flutter_text/assembly_pack/weather/real_time_page.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/utils/permission.dart';
import 'package:flutter_text/utils/screen.dart';
import 'assembly_pack/book/search_book.dart';
import 'assembly_pack/car_pages.dart';
import 'assembly_pack/db_test/test_ui.dart';
import 'assembly_pack/event_bus/event_util.dart';
import 'package:flutter_text/assembly_pack/canvas_paint.dart';
import 'package:flutter_text/assembly_pack/stepper.dart';

import 'assembly_pack/range_slider.dart';
import 'assembly_pack/slideing_panel.dart';
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
import 'utils/init.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (ReportError().isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZonedGuarded<Future<void>>(() async {
    runApp(Assembly());
  }, (error, stackTrace) async {
    await ReportError().reportError(error, stackTrace);
  });
}

///BotToastInit BotToastNavigatorObserver toast弹窗初始化
class Assembly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      child: BotToastInit(
        child: TabBarDemo(),
      ),
    );
  }
}

class TabBarDemo extends StatefulWidget {
  @override
  TabBarDemoState createState() => TabBarDemoState();
}

class TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  StreamSubscription<PageEvent> eventBus;
  String eventData;
  TabController tabController;
  int currentIndex = 0;

  void initState() {
    super.initState();
    Permission.init();
    LocateStorage.init();
    LogUtil.init(isDebug: true);
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });
  }

  Widget build(BuildContext viewContext) {
    return MaterialApp(
      showPerformanceOverlay: GlobalStore.isShowOverlay ?? false,
      title: 'Flutter Study',
      navigatorObservers: [BotToastNavigatorObserver()],
      home: Scaffold(
        appBar: AppBar(
          title: Text('组件列表'),
        ),
        body: Builder(
          builder: (BuildContext context) => TabBarView(
            physics: NeverScrollableScrollPhysics(), //禁止滑动
            controller: tabController,
            children: <Widget>[
              RepaintBoundary(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.chat),
                      title: Text(
                        '聊天室--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => chatPackApp()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.video_call),
                      title: Text(
                        '视频通话装置--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CheckRoomId()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.ondemand_video),
                      title: Text(
                        '本地视频播放--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => videoIndex()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.filter_list),
                      title: Text(
                        '本地视频播放列表--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => VideoList()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.videogame_asset),
                      title: Text(
                        '视频背景登录--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LoginVideoPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.picture_as_pdf),
                      title: Text(
                        '本地pdf查看--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PdfRead()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.file_download),
                      title: Text(
                        '本地pdf下载--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => pdfView()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.wifi),
                      title: Text(
                        '检查连接数据--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ConnectWidget()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.volume_up),
                      title: Text(
                        '录音--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => MicStreamDemo()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.storage),
                      title: Text(
                        'SqlLite--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TestDb()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.recent_actors),
                      title: Text(
                        'register--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.storage),
                      title: Text(
                        'storage--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => StorageTest()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.web),
                      title: Text(
                        'scheme url--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SchemeText()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.link),
                      title: Text(
                        '${GlobalStore.isShowOverlay == false ? '显示' : '关闭'}性能监听 --',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          GlobalStore.isShowOverlay = !GlobalStore.isShowOverlay;
                        });
                      },
                    ),
                  ],
                ),
              ),
              RepaintBoundary(
                child: Container(
                  child: ListView(
                      children: ListTile.divideTiles(context: context, tiles: [
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'SlidingUpPanel使用',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SlidingUpText()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'SlidingUpPanelText使用',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SlidingUpPanelText()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.view_list),
                          title: Text(
                            'A to Z list view',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CarModelsPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: Text(
                            '测试',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => TextT()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.scanner),
                          title: Text(
                            '扫图片条形码',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ScanBook()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.tablet_android),
                          title: Text(
                            '动画常用组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AnimaComponentPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.fastfood),
                          title: Text(
                            '美食列表',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.swap_horizontal_circle),
                          title: Text(
                            '滑块组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => slider()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.slideshow),
                          title: Text(
                            '两端滑块组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => RangeSliderPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.format_line_spacing),
                          title: Text(
                            '水平布局',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => layoutRow()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.inbox),
                          title: Text(
                            '装饰容器',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => decoratedBox()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.input),
                          title: Text(
                            '文本输入框',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
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
                          leading: const Icon(Icons.check_box),
                          title: Text(
                            'checkBox组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => checkBoxListTitle()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.grid_on),
                          title: Text(
                            'GridView组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => gridView()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.bug_report),
                          title: Text(
                            'RaisedButton组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => raisedButton()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.space_bar),
                          title: Text(
                            'FlexibleSpaceBar组件(折叠)',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => flexibleSpaceBar()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.text_fields),
                          title: Text(
                            'eventData的值为：${eventData}',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            eventBus = EventBusUtil.getInstance()
                                .on<PageEvent>()
                                .listen((data) {
                              setState(() {
                                eventData = data.test;
                              });
                              print('onTap打印eventData：$eventData');
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
                                        border: new Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: EventBusDemo(),
                                    ),
                                  );
                                }));
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.receipt),
                          title: Text(
                            'Layout抽屉组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LayoutDemo()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.local_bar),
                          title: Text(
                            '底部导航栏组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => bottomBar()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.more_vert),
                          title: Text(
                            'PopupMenu组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PopupMenu()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.format_align_center),
                          title: Text(
                            'Form组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => FormText()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.format_align_justify),
                          title: Text(
                            'Drag_list组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => DragText()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.input),
                          title: Text(
                            'Slidable组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SlidableText()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'liquid使用',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LiquidText()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'canvas',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => PainterSketchDome()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'stepper',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => StepperDemo()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'photo',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PickImage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'curvedBar',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => curvedBar()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.filter_b_and_w),
                          title: Text(
                            'banner组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => bannerDemo()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.fingerprint),
                          title: Text(
                            'localAuth组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LocalAuthCheck()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.list),
                          title: Text(
                            'SpeedDial组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SpeedDialDemo()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                            'MiniCalendar组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MonthPageViewDemo()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Hero(
                              tag: "calendar",
                              child: const Icon(Icons.calendar_today)),
                          title: Text(
                            'Calendar组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CalendarDemo()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.pie_chart),
                          title: Text(
                            'flutter_picker组件',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => FlutterPickerDemo()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.help),
                          title: Text(
                            'simple_animations组件 -- 小飞机',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Hello()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: Text(
                            '设置',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => overlayDemo()),
                            );
                          },
                        ),
                      ]).toList()),
                ),
              ),
              RepaintBoundary(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.chat),
                      title: Text(
                        '翻译--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => translatePage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.cloud),
                      title: Text(
                        '天 气 预 报',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RealTimePage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(
                        '阅读--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SearchBook()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.video_library),
                      title: Text(
                        '梨视频--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PearVideoFirstPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.contacts), title: Text('聊天室')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.apps), title: Text('组件')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle), title: Text('Api')),
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
      ),
    );
  }
}
