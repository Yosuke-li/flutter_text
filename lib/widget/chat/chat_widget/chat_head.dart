import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/widget/chat/helper/message/message_center.dart';
import 'package:flutter_text/widget/chat/helper/message/message_model.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ChatHeadPage extends StatefulWidget {
  int userId;
  String topic;
  Widget child;

  ChatHeadPage({@required this.topic, this.child, this.userId});

  @override
  _ChatHeadState createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHeadPage> {
  String lastMsg;
  MessageCenter controller;

  @override
  void initState() {
    super.initState();
    controller ??= MessageCenter();
    controller.listenEvent(listenFunc: (MqttReceivedMessage msg) {
      if (msg.topic == widget.topic) {
        final String message =
        MqttPublishPayload.bytesToStringAsString(msg.payload.payload.message);
        final MessageModel model = MessageModel.fromJson(json.decode(message));
        lastMsg = model.msg;
        if (mounted) {
          setState(() {});
        }
        Log.info('lastMsg: $lastMsg');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [widget.child, Text('$lastMsg')],
    );
  }
}
