import 'package:flutter/material.dart';
import 'package:flutter_text/widget/chat/chat_widget/chat_info.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final ChatRoomLogic logic = Get.put(ChatRoomLogic());
  final ChatRoomState state = Get.find<ChatRoomLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${state.topic.value}'),
      ),
      body: Obx(
        () => ChatInfoPage(
          topic: state.topic.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ChatRoomLogic>();
    super.dispose();
  }
}
