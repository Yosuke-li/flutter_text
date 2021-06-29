import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat_self/chat_room/view.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/model/db_user.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/navigator.dart';
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
                        ..name = 'lsd';
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
                  return ListTile(
                    title: Text(e),
                    onTap: () {
                      NavigatorUtils.getXOfPush(context, ChatRoomPage(), arguments: {'topic': e});
                    },
                  );
                })?.toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
