import 'package:self_utils/utils/event_bus/event_util.dart';

import 'package:flutter/material.dart';

import 'event_util.dart';

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
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textController,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
                EventBusUtil.getInstance()
                    ?.fire(PageEvent('${textController.text}'));
              },
              child: const Text('传值'),
            ),
          ],
        ),
      ),
    );
  }
}
