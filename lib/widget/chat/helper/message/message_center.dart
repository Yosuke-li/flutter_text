import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/utils.dart';
import 'package:flutter_text/widget/chat/helper/global/event.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../chat_helper.dart';

class MessageCenter {
  static StreamController<MqttReceivedMessage> _controller =
      StreamController<MqttReceivedMessage>.broadcast();

  static void sendMsg(EventChat event) {
    _controller?.add(event.msg);
  }

  CancelCallBack listenEvent(
      {@required Function(MqttReceivedMessage test) listenFunc}) {
    final CancelCallBack callBack =
        _controller?.stream?.listen((MqttReceivedMessage event) {
      listenFunc(event);
    })?.cancel;
    return callBack;
  }

  void sendOutMsg(String topic, String msg) {
    ChatMsgConduit.sendOutMsg(topic, msg);
  }

  void dispose() {
    _controller.close();
    _controller = null;
    _controller = StreamController<MqttReceivedMessage>.broadcast();
  }
}
