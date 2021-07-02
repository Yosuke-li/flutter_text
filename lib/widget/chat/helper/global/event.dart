import 'package:mqtt_client/mqtt_client.dart';

class EventChat {
  MqttReceivedMessage msg;
}

class DbGlobal {
  static String ip = '47.102.41.197';
  static int port = 5433;
  static String database = 'db4d3c49473a7e4472961204b7a3838a5euser';
  static String username = 'nayo';
}