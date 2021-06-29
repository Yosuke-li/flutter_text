import 'package:flutter/material.dart';

class ChatHeadPage extends StatefulWidget {
  int userId;
  String topic;
  Widget child;

  ChatHeadPage({@required this.topic, this.child, this.userId});

  @override
  _ChatHeadState createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHeadPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(),
          Expanded(child: Container(
            child: Column(
              children: [
                widget.child,

              ],
            ),
          ),),
        ],
      ),
    );
  }
}