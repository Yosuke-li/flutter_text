import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/animation/component.dart';
import 'package:flutter_text/assembly_pack/banner_demo.dart';
import 'package:flutter_text/assembly_pack/bloc_text/bloc_text.dart';
import 'package:flutter_text/assembly_pack/box/box.dart';
import 'package:flutter_text/assembly_pack/chat/chat_main.dart';
import 'package:flutter_text/assembly_pack/chat_self/chat_list.dart';
import 'package:flutter_text/assembly_pack/connected/connect_data.dart';
import 'package:flutter_text/assembly_pack/curved_bar.dart';
import 'package:flutter_text/assembly_pack/db_register/register.dart';
import 'package:flutter_text/assembly_pack/dll_text/dll_text.dart';
import 'package:flutter_text/assembly_pack/drag_list.dart';
import 'package:flutter_text/assembly_pack/flutter_picker.dart';
import 'package:flutter_text/assembly_pack/get_package.dart';
import 'package:flutter_text/assembly_pack/group_list_page.dart';
import 'package:flutter_text/assembly_pack/hello.dart';
import 'package:flutter_text/assembly_pack/intro/intro.dart';
import 'package:flutter_text/assembly_pack/j_book/book_shelf.dart';
import 'package:flutter_text/assembly_pack/j_book/book_view.dart';
import 'package:flutter_text/assembly_pack/liquid_text.dart';
import 'package:flutter_text/assembly_pack/local_auth_check.dart';
import 'package:flutter_text/assembly_pack/local_notification/view.dart';
import 'package:flutter_text/assembly_pack/login/login_video_page.dart';
import 'package:flutter_text/assembly_pack/main.dart';
import 'package:flutter_text/assembly_pack/mic_stream_demo.dart';
import 'package:flutter_text/assembly_pack/mqtt_text/real_time_list/view.dart';
import 'package:flutter_text/assembly_pack/overlay_demo.dart';
import 'package:flutter_text/assembly_pack/pdf.dart';
import 'package:flutter_text/assembly_pack/pdf_read.dart';
import 'package:flutter_text/assembly_pack/pear_video/pear_video.dart';
import 'package:flutter_text/assembly_pack/photo.dart';
import 'package:flutter_text/assembly_pack/refrash_view.dart';
import 'package:flutter_text/assembly_pack/save_text/save_text.dart';
import 'package:flutter_text/assembly_pack/scan_book/scan_book.dart';
import 'package:flutter_text/assembly_pack/scheme_text.dart';
import 'package:flutter_text/assembly_pack/skeleton_view.dart';
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
import 'package:flutter_text/utils/file_utils.dart';
import 'package:flutter_text/utils/listener/listen_test.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/mqtt_helper.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/permission.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/utils/test.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:flutter_text/utils/utils.dart';
import 'package:flutter_text/widget/app_lifecycle_widget.dart';
import 'package:flutter_text/widget/chat/helper/user/user_db.dart';
import 'package:flutter_text/widget/keyboard/keyboard_root.dart';
import 'package:flutter_text/widget/modal_utils.dart';
import 'package:flutter_text/widget/navigator_helper.dart';
import 'package:flutter_text/widget/notification_center/notification_widget.dart';
import 'package:flutter_text/widget/three_d_widget.dart';
import 'package:flutter_text/widget/window.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'assembly_pack/_show_model/show_model.dart';
import 'assembly_pack/book/search_book.dart';
import 'assembly_pack/car_pages.dart';
import 'assembly_pack/db_test/test_ui.dart';
import 'package:flutter_text/assembly_pack/canvas_paint.dart';
import 'package:flutter_text/assembly_pack/stepper.dart';

import 'assembly_pack/event_bus/event_util.dart';
import 'assembly_pack/focus_page.dart';
import 'assembly_pack/getx_text/getx_text/view.dart';
import 'assembly_pack/local_notification/list_view.dart';
import 'assembly_pack/management/home_page/home_page.dart';
import 'assembly_pack/notified_scroll.dart';
import 'assembly_pack/ota_update_text.dart';
import 'assembly_pack/provider/view.dart';
import 'assembly_pack/range_slider.dart';
import 'assembly_pack/search_page.dart';
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

///BotToastInit BotToastNavigatorObserver toast弹窗初始化
class Assembly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TransitionBuilder toastWidget = BotToastInit();
    return ScreenWidget(
      child: NavigatorInitializer(
        child: NotificationListenPage(
          child: AppLifecycleWidget(
            child: ModalStyleWidget(
              child: MaterialApp(
                builder: BotToastInit(),
                navigatorObservers: <NavigatorObserver>[
                  BotToastNavigatorObserver()
                ],
                home: KeyboardRootWidget(
                  child: TabBarDemo(),
                ),
              ),
            ),
          ),
        ),
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
  int tapTimes = 0;

  int lastPressedAt = 0;

  CancelCallBack cancel;

  @override
  void initState() {
    super.initState();
    PostgresUser.init();
    if (Platform.isAndroid || Platform.isIOS) Permission.init();
    LocateStorage.init().whenComplete(
      () => listenTest(),
    );
    FileUtils.init();
    Log.init(isDebug: true);
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    if (cancel != null) {
      cancel?.call(); //dispose销毁缓存
      ListenStateTest.clear();
    }
  }

  //监听案例
  void listenTest() {
    final CancelCallBack callBack =
        ListenStateTest.listenNum(listenFunc: (ListenTestModel test) {
      setState(() {
        tapTimes = test.num;
      });
    });

    setState(() {
      tapTimes = ListenStateTest.getNum();
      cancel = callBack;
    });
  }

  Image getImage(String s) {
    return Image.asset(
      'assets/banner/$s',
      width: MediaQuery.of(context).size.width,
      height: 200,
      fit: BoxFit.fill,
      scale: 3.0,
    );
  }

  @override
  Widget build(BuildContext viewContext) {
    return GetMaterialApp(
      showPerformanceOverlay: GlobalStore.isShowOverlay ?? false,
      title: 'Flutter Study',
      navigatorObservers: <NavigatorObserver>[BotToastNavigatorObserver()],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('组件列表'),
        ),
        body: Builder(
          builder: (BuildContext context) => TabBarView(
            controller: tabController,
            children: <Widget>[
              RepaintBoundary(
                child: ListView(
                  children: <Widget>[
                    RepaintBoundary(
                      child: InteractionalWidget(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        maxAngleY: 30,
                        maxAngleX: 40,
                        middleScale: 1,
                        foregroundScale: 1.1,
                        backgroundScale: 1.3,
                        backgroundWidget: Container(
                          child: getImage('back.png'),
                        ),
                        middleWidget: Container(
                          child: getImage('mid.png'),
                        ),
                        foregroundWidget: Container(
                          child: getImage('fore.png'),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.chat),
                      title: Text(
                        '聊天室--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 1);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ChatPackApp()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.chat),
                      title: Text(
                        '聊天列表--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ChatListWidget()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 2);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CheckRoomId()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 3);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => videoIndex()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 4);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => VideoList()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 5);
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
                        ListenStateTest.setNum(ListenTestModel()..num = 6);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PdfRead()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 7);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => pdfView()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 8);
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
                        ListenStateTest.setNum(ListenTestModel()..num = 9);
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
                        ListenStateTest.setNum(ListenTestModel()..num = 10);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TestDb()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_basket_outlined),
                      title: Text(
                        '骨架屏--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 11);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SkeletonView()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 12);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.chat),
                      title: Text(
                        'mqtt--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 1);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RealTimeListPage()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 13);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => StorageTest()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 14);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SchemeText()),
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
                        ListenStateTest.setNum(ListenTestModel()..num = 15);
                        setState(() {
                          GlobalStore.isShowOverlay =
                          !GlobalStore.isShowOverlay;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.messenger_outline_sharp),
                      title: Text(
                        '本地消息推送',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 16);
                        NavigatorUtils.pushWidget(
                            context, LocalNotification());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.messenger_rounded),
                      title: Text(
                        '本地消息推送2',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 17);
                        NavigatorUtils.pushWidget(
                            context, LocalNotificationList());
                      },
                    ),
                    ListTile(
                      leading:
                      const Icon(Icons.precision_manufacturing_rounded),
                      title: Text(
                        'provider text',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 18);
                        NavigatorUtils.pushWidget(
                            context, ProviderTextPage());
                      },
                    ),
                    ListTile(
                      leading:
                      const Icon(Icons.precision_manufacturing_rounded),
                      title: Text(
                        'management 管理后台',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 19);
                        NavigatorUtils.pushWidget(context, HomePage());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.app_blocking),
                      title: Text(
                        'bloc',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 20);
                        NavigatorUtils.pushWidget(
                            context, BlocTextWidget());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.scanner),
                      title: Text(
                        'url scheme',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () async {
                        //todo market://需要后面对应的app才能打开,只有details也不行
                        launch(
                            'market://details?id=com.example.exhibition');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.airplanemode_on),
                      title: Text(
                        'Getx',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () async {
                        ListenStateTest.setNum(ListenTestModel()..num = 21);
                        final String result =
                        await NavigatorUtils.getXOfPush<String>(
                            context, GetxTextPage(),
                            arguments: <String, dynamic>{'count': 10});
                        Log.info('result: $result');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.dirty_lens),
                      title: Text(
                        'dll 测试页面',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                              builder: (_) => DllTextPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer),
                      title: Text(
                        '点击id ${tapTimes ?? 0}',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      onTap: () {
                        ListenStateTest.setNum(ListenTestModel()..num = 0);
                      },
                    ),
                  ],
                ),
              ),
              RepaintBoundary(
                child: Container(
                  child: ListView(
                      children:
                      ListTile.divideTiles(context: context, tiles: [
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
                            'text',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => OtaUpdateWidget()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            '搜索',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SearchDemoPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            '金融list',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DemoPage(MediaQuery.of(context).size)),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.group_add),
                          title: Text(
                            '分组列表',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => GroupListPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.group_add),
                          title: Text(
                            '懒加载列表',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => NotifiedScrollPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.line_style_rounded),
                          title: Text(
                            'ReFresh使用',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => RefreshPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.line_style_rounded),
                          title: Text(
                            'intro 引导教程页',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => IntroPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.keyboard),
                          title: Text(
                            'modal Utils使用',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            ModalText.model(context);
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
                          leading: const Icon(Icons.backpack),
                          title: Text(
                            '获取package info',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => GetPackageWidget()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.account_box),
                          title: Text(
                            'Box合集',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => BoxPage()),
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
                              MaterialPageRoute(
                                  builder: (context) => ScanBook()),
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
                                  builder: (BuildContext context) =>
                                      RangeSliderPage()),
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
                              MaterialPageRoute(
                                  builder: (context) => layoutRow()),
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
                              MaterialPageRoute(
                                  builder: (context) => decoratedBox()),
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
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TextFieldPage()),
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
                              MaterialPageRoute(
                                  builder: (context) => gridView()),
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
                              MaterialPageRoute(
                                  builder: (context) => raisedButton()),
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
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
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
                              MaterialPageRoute(
                                  builder: (context) => LayoutDemo()),
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
                              MaterialPageRoute(
                                  builder: (context) => bottomBar()),
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
                              MaterialPageRoute(
                                  builder: (context) => PopupMenu()),
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
                              MaterialPageRoute(
                                  builder: (context) => FormText()),
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
                              MaterialPageRoute(
                                  builder: (context) => DragText()),
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
                              MaterialPageRoute(
                                  builder: (context) => SlidableText()),
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
                              MaterialPageRoute(
                                  builder: (context) => LiquidText()),
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
                              MaterialPageRoute(
                                  builder: (context) => StepperDemo()),
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
                              MaterialPageRoute(
                                  builder: (context) => PickImage()),
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
                              MaterialPageRoute(
                                  builder: (context) => curvedBar()),
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
                              MaterialPageRoute(
                                  builder: (context) => bannerDemo()),
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
                              MaterialPageRoute(
                                  builder: (context) => overlayDemo()),
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
                          MaterialPageRoute(
                              builder: (context) => RealTimePage()),
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
                          MaterialPageRoute(
                              builder: (context) => SearchBook()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(
                        '书架--',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BookShelf()),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: '聊天室'),
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: '组件'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Api'),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            tabController.animateTo(index,
                duration: Duration(milliseconds: 300),
                curve: Curves.linear);
          },
        ),
      ),
    );
  }
}
