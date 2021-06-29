import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/widget/chat/helper/chat_helper.dart';

class ChatConnectWidget extends StatefulWidget {
  @override
  Key key;
  Widget child;

  ChatConnectWidget({this.key, this.child});

  @override
  _ChatConnectState createState() => _ChatConnectState();
}

class _ChatConnectState extends State<ChatConnectWidget> {
  @override
  void initState() {
    super.initState();
    clientConnect();
  }

  void clientConnect() {
    if (GlobalStore.user != null &&
        GlobalStore.user.name != null &&
        GlobalStore.user.name.isNotEmpty == true) {
      ChatHelper.init();
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant ChatConnectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    Log.info('${widget.key}');
    if (widget.key != oldWidget.key) {
      clientConnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
