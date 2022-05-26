import 'package:flutter_text/assembly_pack/controller_test/controller.dart';
import 'package:flutter_text/init.dart';

class ListenerPage extends StatefulWidget {
  Controller controller;

  ListenerPage({required this.controller});

  @override
  _ListenerState createState() => _ListenerState();
}

class _ListenerState extends State<ListenerPage> {
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = widget.controller.currentDate;
    widget.controller.addListener(() {
      time = widget.controller.currentDate;
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('now: $time'),
    );
  }
}
