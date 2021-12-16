import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/lock.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/widget/chat/helper/message/message_control.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../chat_helper.dart';
import 'message_model.dart';

mixin MessageCenter<T extends StatefulWidget> on State<T> {
  final Lock _lock = Lock();

  MessageControl control = MessageControl();

  String get topic;

  //注册监听标记
  @override
  void initState() {
    super.initState();
    control.init(topic);
  }

  //监听消息
  void listener(void Function(MessageModel msg) getLastMsg) {
    Log.info('MessageCenter: ${control.hashCode}');
    control.listenEvent(listenFunc: (MqttReceivedMessage msg) {
      final String message = utf8.decode(msg.payload.payload.message);
      final MessageModel model = MessageModel.fromJson(json.decode(message));
      getLastMsg(model);
    });
  }

  Future<void> getLastMsgWithTopic(void Function(MessageModel msg) getLastMsg) async {
    List<MessageModel> list = <MessageModel>[];
    await getTopicMsg((List<MessageModel> getMsg) {
      list = getMsg;
    });
    if (list.isNotEmpty == true) {
      getLastMsg(list[list.length - 1]);
    }
  }

  //获取该主题下的所有消息
  Future<void> getTopicMsg(
      void Function(List<MessageModel> list) getMsg) async {
    final List<MqttReceivedMessage> msg = ChatMsgConduit.getMsgWithTopic(topic);
    final List<MessageModel> msgs = <MessageModel>[];
    await _lock.mutex(() async {
      msg.forEach((MqttReceivedMessage element) {
        final String message = utf8.decode(element.payload.payload.message);
        final MessageModel model = MessageModel.fromJson(json.decode(message));
        msgs.add(model);
      });
    });
    getMsg(msgs);
  }

  //发送消息
  void sendMsg(String jsonMsg) {
    control.sendOutMsg(topic, jsonMsg);
  }
}
