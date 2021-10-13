import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';

class MicStreamDemo extends StatefulWidget {

  @override
  MicStreamDemoState createState() => MicStreamDemoState();
}

class MicStreamDemoState extends State<MicStreamDemo> {
  FlutterPluginRecord recordPlugin = new FlutterPluginRecord();
  String tempVoice = "images/voice_volume_1.png";

  @override
  void initState() {
    super.initState();
    recordPlugin.init();

    recordPlugin.responseFromAmplitude.listen((data) {
      var voiceData = double.parse(data.msg);
      setState(() {
        if (voiceData > 0 && voiceData < 0.1) {
          tempVoice = "images/voice/voice_volume_2.png";
        } else if (voiceData > 0.2 && voiceData < 0.3) {
          tempVoice = "images/voice/voice_volume_3.png";
        } else if (voiceData > 0.3 && voiceData < 0.4) {
          tempVoice = "images/voice/voice_volume_4.png";
        } else if (voiceData > 0.4 && voiceData < 0.5) {
          tempVoice = "images/voice/voice_volume_5.png";
        } else if (voiceData > 0.5 && voiceData < 0.6) {
          tempVoice = "images/voice/voice_volume_6.png";
        } else if (voiceData > 0.6 && voiceData < 0.7) {
          tempVoice = "images/voice/voice_volume_7.png";
        } else if (voiceData > 0.7 && voiceData < 1) {
          tempVoice = "images/voice/voice_volume_7.png";
        }
      });
      print("振幅大小   " + voiceData.toString());
    });
  }

  void dispose() {
    recordPlugin.stop();
    recordPlugin.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('录制'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0x50000000),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                recordPlugin.start();
              },
              child: Text('开始录制'),
            ),
            GestureDetector(
              onTap: () {
                recordPlugin.stop();
              },
              child: Text('停止录制'),
            ),
            GestureDetector(
              onTap: () {
                recordPlugin.play();
              },
              child: Text('播放'),
            ),
            Container(
              color: Color(0x50000000),
              child: Image.asset(tempVoice),
            ),
          ],
        ),
      ),
    );
  }
}
