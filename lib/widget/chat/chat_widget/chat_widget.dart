import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:self_utils/utils/log_utils.dart';
import 'package:flutter_text/widget/chat/helper/chat_helper.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ChatConnectWidget extends StatefulWidget {
  @override
  Key? key;
  Widget child;

  ChatConnectWidget({this.key, required this.child});

  @override
  _ChatConnectState createState() => _ChatConnectState();
}

class _ChatConnectState extends State<ChatConnectWidget>
    with AutomaticKeepAliveClientMixin<ChatConnectWidget> {
  @override
  void initState() {
    super.initState();
    clientConnect();
  }

  void clientConnect() {
    if (GlobalStore.user != null &&
        GlobalStore.user?.name != null &&
        GlobalStore.user?.name?.isNotEmpty == true) {
      if (ChatHelper.client?.connectionStatus?.state !=
          MqttConnectionState.connecting) {
        ChatHelper.init();
      }
    }
  }

  @override
  void didUpdateWidget(covariant ChatConnectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.key != oldWidget.key) {
      clientConnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
