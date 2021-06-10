import 'dart:io';

import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/utils/api_exception.dart';
import 'package:flutter_text/utils/event_bus_helper.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

///MqttServerClient('ws://', '')
///client.useWebSocket
class MqttHelper {
  static MqttServerClient client;

  static Future<void> connect() async {
    // client = MqttServerClient('ws://172.31.41.83/mqtt', '');
    client = MqttServerClient.withPort('broker.emqx.io', '', 1883);
    client.logging(on: false);
    // client.port = 8888;
    // client.useWebSocket = true;
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } on SocketException catch (e) {
      print(e);
      client.disconnect();
    } catch (e) {
      print(e);
      client.disconnect();
    }

    client.subscribe("topic/test1", MqttQos.atLeastOnce);

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      EventBusHelper.asyncStreamController
          .add(EventCache()..realTimeData = payload);
      print('${c[0].topic} Received message: $payload');
    });
  }

  // 连接成功
  static void onConnected() {
    print('Connected');
  }

  // 连接断开
  static void onDisconnected() {
    print('Disconnected');
    throw ApiException(401, 'mqtt disConnected');
  }

  // 订阅主题成功
  static void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  // 订阅主题失败
  static void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  // 成功取消订阅
  static void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

  // 收到 PING 响应
  static void pong() {
    print('Ping response client callback invoked');
  }
}
