import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(TextT());

class TextT extends StatefulWidget {
  TextState createState() => TextState();
}

class TextState extends State<TextT> {
  int count = 10;
  static const plat = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = 'Unknow';

  Future<Null> _getBatteryLevel() async {
    String battery;
    try {
      final int result = await plat.invokeMethod('getBatteryLevel');
      battery = "Battery level at $result";
    } catch (e) {
      battery = 'error: ${e}';
    }
    setState(() {
      _batteryLevel = battery;
    });
  }

  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: Center(
        child: Text(_batteryLevel),
      ),
    );
  }
}
