part of 'chat_helper.dart';

//消息总管道
class ChatMsgConduit {
  static List<MqttReceivedMessage> msgList = <MqttReceivedMessage>[];

  static void listener() {
    ChatHelper.client.updates
        .listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttPublishMessage m = event[0].payload;
      final String message =
          MqttPublishPayload.bytesToStringAsString(m.payload.message);
      msgSendCenter(event[0]);
      Log.info('${event[0].topic} $message');
    });
  }

  static void msgSendCenter(MqttReceivedMessage event) {
    msgList.add(event);
    MessageControl.sendMsg(EventChat()..msg = event);
  }

  //获取对应topic的记录
  static List<MqttReceivedMessage> getMsgWithTopic(String topic) {
    return msgList
        .where((MqttReceivedMessage element) => element.topic == topic)
        .toList();
  }

  static void sendOutMsg(String topic, String msg) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    ChatHelper.client
        .publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
  }
}
