import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_text/widget/flutter_text.dart';

void main() => runApp(new ShareText());

class ShareText extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'slider Study',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('MusicPlayer 组件'),
        ),
        body: Center(
          child: contextPage(),
        ),
      ),
    );
  }
}

class contextPage extends StatefulWidget  {

  @override
  State<StatefulWidget> createState() => contextPageState();

}

class contextPageState extends State<contextPage> {
  MusicFinder audioPlayer = new MusicFinder();
  var songs = MusicFinder.allSongs();
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: FlutterText(
          '你好', TextStyle(fontSize: ScreenUtil().setSp(40))
      ),
    );
  }
}
