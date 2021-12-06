import 'package:flutter/material.dart';
import 'package:flutter_text/utils/log_utils.dart';

class NotifiedScrollPage extends StatefulWidget {
  @override
  NotifiedScrollState createState() => NotifiedScrollState();
}

class NotifiedScrollState extends State<NotifiedScrollPage> {
  bool isScrolling = false;

  String netImageUrl =
      "https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0a4ce25d48b8405cbf5444b6195928d4~tplv-k3u1fbpfcp-no-mark:0:0:0:0.awebp";

  bool notificationFunc(Notification notification) {
    switch (notification.runtimeType) {
      case ScrollStartNotification:
        Log.info('开始滚动');
        isScrolling = false;
        break;
      case ScrollUpdateNotification:
        break;
      case ScrollEndNotification:
        Log.info('停止滚动');
        isScrolling = true;
        break;
      case OverscrollNotification:
        break;
    }
    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        child: buildListView(),
        onNotification: notificationFunc,
      ),
    );
  }

  ListView buildListView() {
    return ListView.separated(
      itemCount: 1000, //子条目个数
      ///构建每个条目
      itemBuilder: (BuildContext context, int index) {
        if (isScrolling) {
          ///这时将子条目单独封装在了一个StatefulWidget中
          return Image.network(
            netImageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.fitHeight,
          );
        } else {
          return Container(
            height: 100,
            width: 100,
            child: Text("加载中..."),
          ); //占位
        }
      },

      //构建每个子Item之间的间隔Widget
      separatorBuilder: (BuildContext context, int index) {
        return new Divider();
      },
    );
  }
}
