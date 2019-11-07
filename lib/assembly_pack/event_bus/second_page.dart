import 'event_util.dart';
import 'package:flutter/material.dart';

class EventBusDemo2 extends StatefulWidget {
  @override
  _EventBusDemo2State createState() => _EventBusDemo2State();
}

class _EventBusDemo2State extends State<EventBusDemo2> {
  TextEditingController textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(bottom: 25),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: textController,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    EventBusUtil.getInstance().fire(PageEvent('${textController.text}'));
                  },
                  child: Text('传值'),
                ),
              ],
            )));
  }
}
