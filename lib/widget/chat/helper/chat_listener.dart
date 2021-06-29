part of 'chat_helper.dart';

//消息总管道
class ChatMsgConduit {
  static void listener() {
    ChatHelper.client.updates
        .listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttPublishMessage m = event[0].payload;
      final String message =
      MqttPublishPayload.bytesToStringAsString(m.payload.message);
      Log.info(message);
    });
  }
}
