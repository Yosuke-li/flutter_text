import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat_self/chat_room/view.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/model/db_user.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/widget/chat/chat_widget/chat_head.dart';
import 'package:flutter_text/widget/chat/chat_widget/chat_widget.dart';
import 'package:flutter_text/widget/chat/helper/chat_helper.dart';

class ChatListWidget extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatListWidget> {
  List<String> rooms = [];

  @override
  void initState() {
    super.initState();
    getRoom();
  }

  void getRoom() {
    rooms = ChatHelper.getSubscribe();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChatConnectWidget(
      key: Key(GlobalStore.user?.id.hashCode.toString() ?? ''),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('聊天'),
          actions: [
            if (GlobalStore.user == null ||
                GlobalStore.user.name.isEmpty == true)
              Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    child: const Text('登陆'),
                    onTap: () {
                      GlobalStore.user = User()
                        ..id = 7595
                        ..image = 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201311%2F17%2F174124tp3sa6vvckc25oc8.jpg&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1625624528&t=f27d73f1455c17f3fc1c4296f0e11957'
                        ..name = 'coco';
                      setState(() {});
                      getRoom();
                    },
                  ),
                ),
              )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: rooms?.map((e) {
                  return ChatHeadPage(
                    topic: e,
                    child: ListTile(
                      title: Text(e),
                      onTap: () {
                        NavigatorUtils.getXOfPush(context, ChatRoomPage(),
                            arguments: {'topic': e});
                      },
                    ),
                  );
                })?.toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
