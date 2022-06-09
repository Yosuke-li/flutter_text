import 'package:flutter_text/assembly_pack/compress/video_compress.dart';
import 'package:flutter_text/assembly_pack/menu_item.dart';
import 'package:flutter_text/assembly_pack/redis_test.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:flutter_text/widget/float_box.dart';
import 'package:url_launcher/url_launcher.dart';

import 'assembly_pack/PopupText.dart';
import 'assembly_pack/api_exception_page.dart';
import 'assembly_pack/choose_seat/StreamText.dart';
import 'assembly_pack/choose_seat/choose_seat.dart';
import 'assembly_pack/controller_test/test_page.dart';
import 'assembly_pack/decode_gif.dart';
import 'assembly_pack/compress/image_compress.dart';
import 'assembly_pack/desktop_list/desktop_component.dart';
import 'assembly_pack/keyboardPage.dart';
import 'assembly_pack/lazy_list/lazy_list_page.dart';
import 'assembly_pack/lazy_list/normal_list_page.dart';
import 'assembly_pack/mouse_text.dart';
import 'assembly_pack/music_play/music_play.dart';
import 'assembly_pack/other_charts/list_group.dart';
import 'assembly_pack/pc_keyboard.dart';
import 'assembly_pack/scratchable/scratchable_info.dart';
import 'assembly_pack/slide_image/slide_image.dart';
import 'assembly_pack/unit/unit_component.dart';
import 'init.dart';

import 'assembly_pack/slideing_panel.dart';
import 'assembly_pack/sliding_up_panel.dart';
import 'assembly_pack/layout_row.dart';
import 'assembly_pack/decorated_box.dart';
import 'assembly_pack/text_field.dart';
import 'assembly_pack/check_box_list_title.dart';
import 'assembly_pack/gridview.dart';
import 'assembly_pack/raised_button.dart';
import 'assembly_pack/flexible_space_bar.dart';
import 'widget/drag_overlay.dart';

part 'index.init.dart';

class MainIndexPage extends StatefulWidget {
  @override
  MainIndexState createState() => MainIndexState();
}

class MainWidgetModel {
  String title;
  Widget icon;
  Widget? route;
  void Function(BuildContext context)? onTapFunc;

  MainWidgetModel(
      {required this.title, required this.icon, this.route, this.onTapFunc});
}

class MainIndexState extends State<MainIndexPage>
    with SingleTickerProviderStateMixin {
  StreamSubscription<PageEvent>? eventBus;
  String? eventData;
  late TabController tabController;
  int currentIndex = 0;
  int tapTimes = 0;

  int lastPressedAt = 0;

  CancelCallBack? cancel;

  static OverlayEntry? entry;

  List<MainWidgetModel> _page1 = [];
  List<MainWidgetModel> _page2 = [];
  List<MainWidgetModel> _page3 = [];

  @override
  void initState() {
    super.initState();
    PostgresUser.init();
    if (Platform.isAndroid || Platform.isIOS) Permissions.init();
    FileUtils();
    Log.init(isDebug: true);
    listenTest();
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });

    //组件完成之后的回调方法
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (Platform.isWindows || Platform.isMacOS) _showEntry();
    });

    _page1 = page1;
    _page2 = page2;
    _page3 = page3;
    setState(() {});
  }

  void _showEntry() {
    entry?.remove();
    entry = null;
    entry = OverlayEntry(builder: (context) {
      return FloatBox(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onTap: () async {
          final NavigatorState navigatorHelper =
              await NavigatorHelper.navigatorState;
          if (navigatorHelper.canPop() == true) {
            navigatorHelper.pop();
          }
        },
      );
    });
    Overlay.of(context)?.insert(entry!);
    setState(() {});
  }

  @override
  void dispose() {
    if (mounted) {
      return;
    }
    if (cancel != null) {
      cancel?.call(); //dispose销毁缓存
      ListenStateTest.clear();
    }
    if (Platform.isWindows) {
      entry?.remove();
    }
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('组件列表'),
      ),
      body: Builder(
        builder: (BuildContext context) => TabBarView(
          controller: tabController,
          children: <Widget>[
            RepaintBoundary(
              child: SingleChildScrollView(
                child: Column(
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final MainWidgetModel mainModel =
                            ArrayHelper.get(_page1, index)!;
                        return ListTile(
                          leading: mainModel.icon,
                          title: Text(
                            '${mainModel.title}',
                            style: TextStyle(
                              fontSize: screenUtil.adaptive(40),
                            ),
                          ),
                          onTap: () {
                            if (mainModel.route != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => mainModel.route!),
                              );
                            } else {
                              mainModel.onTapFunc?.call(context);
                            }
                          },
                        );
                      },
                      itemCount: _page1.length,
                    )
                  ],
                ),
              ),
            ),
            RepaintBoundary(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final MainWidgetModel mainModel =
                        ArrayHelper.get(_page2, index)!;
                    return ListTile(
                      leading: mainModel.icon,
                      title: Text(
                        '${mainModel.title}',
                        style: TextStyle(
                          fontSize: screenUtil.adaptive(40),
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        if (mainModel.route != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => mainModel.route!),
                          );
                        } else {
                          mainModel.onTapFunc?.call(context);
                        }
                      },
                    );
                  },
                  itemCount: _page2.length,
                ),
              ),
            ),
            RepaintBoundary(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final MainWidgetModel mainModel =
                  ArrayHelper.get(_page3, index)!;
                  return ListTile(
                    leading: mainModel.icon,
                    title: Text(
                      '${mainModel.title}',
                      style: TextStyle(
                        fontSize: screenUtil.adaptive(40),
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      if (mainModel.route != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => mainModel.route!),
                        );
                      } else {
                        mainModel.onTapFunc?.call(context);
                      }
                    },
                  );
                },
                itemCount: _page3.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: '聊天室'),
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
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        },
      ),
    );
  }
}
