import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_text/widget/video_widget.dart';
import 'package:image_picker_saver/image_picker_saver.dart';

class videoIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: contextPage(),
      ),
    );
  }
}

class contextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => contextPageState();
}

class contextPageState extends State<contextPage> {
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  late File _video;

  Size get _window => MediaQuery.of(context).size;

//  https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo-transcode-crf/60609889_0b5d29ee8e09fad4cc4f40f314d737ca_0.mp4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // 该组件宽高默认填充父控件，你也可以自己设置宽高
            child: _video == null || _video == ''
                ? VideoPlayerPage(
              //network视频
              url:
              'https://video.pearvideo.com/mp4/adshort/20200520/cont-1675664-15155134_adpkg-ad_hd.mp4',
              title: '示例视频',
              width: _window.width,
              height:
              _isFullScreen ? _window.height : _window.width / 16 * 9,
            )
                : VideoPlayerPage(
              //本地file视频
              file: _video,
              title: '示例视频',
              width: _window.width,
              height:
              _isFullScreen ? _window.height : _window.width / 16 * 9,
            )),
        floatingActionButton: !_isFullScreen
            ? FloatingActionButton(
          onPressed: () async {
            final File video =
            await ImagePickerSaver.pickVideo(source: ImageSource.gallery);
            if (video != null && video.path != '') {
              setState(() {
                _video = video;
              });
            }
          },
          tooltip: 'pickImage',
          child: Icon(Icons.add),
        )
            : null);
  }
}


