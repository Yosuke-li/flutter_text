import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/video_player/windows/play_video_windows.dart';
import 'package:flutter_text/global/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:self_utils/widget/video_widget.dart';

class VideoIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => contextPageState();
}

class contextPageState extends State<VideoIndex> {
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  File? _video;
  final ImagePicker _picker = ImagePicker();

  Size get _window => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return GlobalStore.isMobile
        ? Scaffold(
            body: Container(
                // 该组件宽高默认填充父控件，你也可以自己设置宽高
                child: _video == null || _video == ''
                    ? VideoPlayerPage(
                        //network视频
                        url:
                            'https://video.pearvideo.com/mp4/adshort/20200520/cont-1675664-15155134_adpkg-ad_hd.mp4',
                        title: '示例视频',
                        width: _window.width,
                        height: _isFullScreen
                            ? _window.height
                            : _window.width / 16 * 9,
                      )
                    : VideoPlayerPage(
                        //本地file视频
                        file: _video,
                        title: '示例视频',
                        width: _window.width,
                        height: _isFullScreen
                            ? _window.height
                            : _window.width / 16 * 9,
                      )),
            floatingActionButton: !_isFullScreen
                ? FloatingActionButton(
                    onPressed: () async {
                      final XFile? video = await _picker.pickVideo(
                          source: ImageSource.gallery);
                      if (video != null && video.path != '') {
                        setState(() {
                          _video = File(video.path);
                        });
                      }
                    },
                    tooltip: 'pickImage',
                    child: Icon(Icons.add),
                  )
                : null)
        : const PlayVideoWindows();
  }
}
