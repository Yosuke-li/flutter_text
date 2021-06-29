part of 'chat_helper.dart';

class ChatState {
  // 连接成功
  static void onConnected() {
    print('Connected');
  }

  // 连接断开
  static void onDisconnected() {
    print('Disconnected');
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