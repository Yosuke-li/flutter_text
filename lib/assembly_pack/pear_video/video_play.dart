import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_text/api/pear_video.dart';
import 'package:flutter_text/model/pear_video.dart';
import 'package:flutter_text/widget/video_widget.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(PearVideoPlay());

class PearVideoPlay extends StatefulWidget {
  PearVideoPlayState createState() => PearVideoPlayState();
}

class PearVideoPlayState extends State<PearVideoPlay> {
  SwiperController swperController = SwiperController();
  List<ContList> _videoList = [];
  void _getPearVideoList() async {
    final result = await PearVideoApi().getPearVideoList();
    setState(() {
      _videoList = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPearVideoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Swiper(
                  loop: false,
                  itemCount: 0,
                  onIndexChanged: (val) {

                  },
                  controller: swperController,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return VideoPlayerText(
                      url: _videoList[index].coverVideo,
                      title: '示例视频',
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
