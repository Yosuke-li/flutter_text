import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_text/global/global.dart';
import 'package:self_utils/utils/api_exception.dart';
import 'package:self_utils/utils/log_utils.dart';
import 'package:flutter_text/widget/chat/helper/global/event.dart';
import 'package:flutter_text/widget/chat/helper/message/message_control.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

part 'chat_listener.dart';

part 'chat_state.dart';

class ChatHelper {
  static MqttServerClient? client;

  static int _reconnectTime = 0;

  static Timer? _timer;

  static MqttConnectMessage message = MqttConnectMessage()
      .withClientIdentifier('${GlobalStore.user?.name.hashCode}')
      .withWillTopic('willtopic')
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.exactlyOnce);

  static void init() async {
    // client = MqttServerClient('ws://172.31.41.83/mqtt', '');
    client ??= MqttServerClient.withPort('broker.emqx.io', '', 1883);
    client?.logging(on: false);
    // client.port = 8888;
    // client.useWebSocket = true;
    client?.keepAlivePeriod = 20;
    client?.onAutoReconnect = ChatState.onReconnected;
    client?.onConnected = ChatState.onConnected;
    client?.onDisconnected = ChatState.onDisconnected;
    client?.onUnsubscribed = ChatState.onUnsubscribed as UnsubscribeCallback?;
    client?.onSubscribed = ChatState.onSubscribed;
    client?.onSubscribeFail = ChatState.onSubscribeFail;
    client?.pongCallback = ChatState.pong;
    client?.connectionMessage = message;

    try {
      await client?.connect();

      final List<String> topics = getSubscribe();

      topics.forEach((String element) {
        setSubscribe(element);
      });

      _reconnectTime = 0;
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }

      ChatMsgConduit.listener();
    } on SocketException catch (e) {
      Log.info(e);
      client?.onAutoReconnect!();
    } catch (e) {
      Log.info(e);
      client?.disconnect();
      throw ApiException(401, 'mqtt disConnected');
    }
  }

  static List<String> getSubscribe() {
    if (GlobalStore.user != null && GlobalStore.user?.name?.isNotEmpty == true) {
      final List<String> topics = <String>['topic/test2', 'topic/test3'];
      return topics;
    }
    return <String>[];
  }

  //todo 重连？？？
  static void reconnect() async {
    if (_reconnectTime < 2) {
      _reconnectTime++;
      Log.info('reConnect');
      _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        init();
      });
    } else {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
      throw ApiException(401, 'mqtt disConnected');
    }
  }

  //设置主题
  static void setSubscribe(String topic) {
    client?.subscribe(topic, MqttQos.exactlyOnce);
  }
}
