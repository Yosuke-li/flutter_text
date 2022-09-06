import 'second_page.dart';
import 'event_util.dart';
import 'package:flutter/material.dart';

class EventBusDemo extends StatefulWidget {
  @override
  _EventBusDemoState createState() => _EventBusDemoState();
}

class _EventBusDemoState extends State<EventBusDemo> {
  StreamSubscription<PageEvent>? eventBus;
  String? eventData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: const Center(
//              child: Text('${eventData}' == ''|| '${eventData}' == null ? '' : '${eventData}'),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return Center(
                        child: Container(
                          width: 350,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: EventBusDemo2(),
                        ),
                      );
                    }
                  )
              );
              },
            child: Text('点我进入下一页'),
          ),
        ],
      ),
    );
  }
}