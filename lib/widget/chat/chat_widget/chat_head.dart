import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/widget/chat/helper/message/message_center.dart';
import 'package:flutter_text/widget/chat/helper/message/message_control.dart';
import 'package:flutter_text/widget/chat/helper/message/message_model.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ChatHeadPage extends StatefulWidget {
  int userId;
  String topic;
  Widget child;

  ChatHeadPage({Key key, @required this.topic, this.child, this.userId});

  @override
  _ChatHeadState createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHeadPage> with MessageCenter<ChatHeadPage> {
  String lastMsg;

  @override
  void initState() {
    super.initState();
    listener((MessageModel msg) {
      lastMsg = msg.msg;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [widget.child, Text('$lastMsg')],
    );
  }

  @override
  String get topic => widget.topic;
}
