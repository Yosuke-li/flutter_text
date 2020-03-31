import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/api/baidu_tts.dart';
import 'package:flutter_text/api/book.dart';
import 'package:flutter_text/model/baidu_tts.dart';
import 'package:flutter_text/model/book.dart';

void main() => runApp(ChaptersDetail());

class ChaptersDetail extends StatefulWidget {
  String link; //章节link

  ChaptersDetail({
    this.link,
  });

  ChaptersDetailState createState() => ChaptersDetailState();
}

class ChaptersDetailState extends State<ChaptersDetail> {
  AudioPlayer audioPlayer = new AudioPlayer();
  ScrollController _scrollController = ScrollController();
  Token _token;
  ChapterInfo _chapterInfo;
  bool isPlay = false;
  bool isShow = false; //防止爆红
  bool isShowBar = false; //显示工具栏
  double _fontsize = 16.0; //字体大小
  double _leading = 1.2; //字体行距
  Timer _timer;
  double _controlOpacity = 0.0; //透明度动画
  List ttsList = [];
  int count = 600;

  double sliderValue = 0.0; //滑块位置

  //获取章节详情
  void getChaptersDetail() async {
    final result = await BookApi().getChaptersDetail(widget.link);
    if (result == null) {
    } else {
      setState(() {
        _chapterInfo = result;
        isShow = true;
      });
    }
    getTtsList();
  }

  //获取百度tts的token
  void getToken() async {
    final result = await BaiduTtsApi().getBaiduToken();
    if (result != null) {
      setState(() {
        _token = result;
      });
    }
  }

  //截取字符串
  void getTtsList() async {
    ttsList = [];
    for (int first = 0; first < _chapterInfo.cpContent.length;) {
      if (first + count >= _chapterInfo.cpContent.length) {
        int last = _chapterInfo.cpContent.length;
        ttsList.add(_chapterInfo.cpContent.substring(first, last));
        break;
      } else {
        ttsList.add(_chapterInfo.cpContent.substring(first, first + count));
        first = first + count;
      }
    }
  }

  //播放
  Future<void> play(url) async {
    await audioPlayer.play(url);
  }

  //播放列表
  Future<void> playList(int i) async {
    await audioPlayer.play(BaiduTtsApi().TtsUrl +
        Uri.encodeComponent(ttsList[i]) +
        BaiduTtsApi().TTs_text +
        _token.access_token);
    setState(() {
      isPlay = true;
    });
    audioPlayer.onPlayerStateChanged.listen((p) async {
      if (p == AudioPlayerState.COMPLETED) {
        i++;
        playList(i);
      }
    });
  }

  //暂停
  Future<void> playPause() async {
    await audioPlayer.pause();
    setState(() {
      isPlay = false;
    });
  }

  void initState() {
    super.initState();
    getToken();
    SystemChrome.setEnabledSystemUIOverlays([]);
    getChaptersDetail();
    _listenScrollView();
  }

  void dispose() {
    super.dispose();
    audioPlayer.pause();
    audioPlayer.dispose();
    _scrollController.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  // 计时器，用法和前端js的大同小异
  void _startControlTimer() {
    if (_timer != null) _timer.cancel();
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        _controlOpacity = 0;
        Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
          isShowBar = false;
        });
      });
    });
  }

  void _listenScrollView() {
    _scrollController.addListener(() {
      setState(() {
        sliderValue = (_scrollController.offset /
            _scrollController.position.maxScrollExtent);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isShow
          ? Stack(
              children: <Widget>[
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    color: Color(0xffFAF9DE),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                    child: Text(
                      _chapterInfo.cpContent,
                      style: TextStyle(letterSpacing: 4.0, fontSize: _fontsize),
                      strutStyle: StrutStyle(leading: _leading),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Offstage(
                    offstage: !isShowBar,
                    child: AnimatedOpacity(
                      opacity: _controlOpacity,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        color: Color(0x40000000),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _chapterInfo.title,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isShowBar) {
                            if (_timer != null) _timer.cancel();
                            _timer = Timer(Duration(seconds: 3), () {
                              _controlOpacity = 0;
                              Future.delayed(Duration(milliseconds: 300))
                                  .whenComplete(() {
                                isShowBar = false;
                              });
                            });
                          } else {
                            isShowBar = true;
                            _controlOpacity = 1;
                            _startControlTimer();
                          }
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: _bottomContainer(),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _bottomContainer() {
    return Offstage(
      offstage: !isShowBar,
      child: AnimatedOpacity(
        opacity: _controlOpacity,
        duration: Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: Color(0x40000000),
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.greenAccent,
                    inactiveTrackColor: Colors.green,
                    valueIndicatorColor: Colors.green,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    thumbColor: Colors.blueAccent,
                    overlayColor: Colors.white,
                    inactiveTickMarkColor:
                    Colors.white, //divsions对进度条先分割后，断续线中间间隔的颜色
                  ),
                  child: Slider(
                    value: sliderValue,
                    label: '${sliderValue * 100}%',
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    onChanged: (val) {
                      _scrollController.jumpTo(
                          _scrollController.position.maxScrollExtent * val);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.font_download),
                    onPressed: () {
                      _changeFont();
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(!isPlay ? Icons.volume_up : Icons.pause),
                    onPressed: () {
                      !isPlay ? playList(0) : playPause();
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.line_style),
                    onPressed: () {
                      _changeLead();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //字体大小修改
  void _changeFont() {
    if (isShowBar) {
      if (_fontsize > 35) {
        _fontsize = 16.0;
      } else {
        _fontsize = _fontsize + 5.0;
      }
      setState(() {
        _fontsize = _fontsize;
      });
    }
  }

  //行间距修改
  void _changeLead() {
    if (isShowBar) {
      if (_leading > 2.0) {
        _leading = 1.2;
      } else {
        _leading = _leading + 0.2;
      }
      setState(() {
        _leading = _leading;
      });
    }
  }
}
