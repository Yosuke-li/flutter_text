import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/api/book.dart';
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
  ChapterInfo _chapterInfo;
  bool isShow = false; //防止爆红
  bool isShowBar = false; //显示工具栏
  double _fontsize = 16.0; //字体大小
  double _leading = 1.2; //字体行距
  Timer _timer;
  double _controlOpacity = 0.0; //透明度动画

  void getChaptersDetail() async {
    final result = await BookApi().getChaptersDetail(widget.link);
    if (result == null) {
    } else {
      setState(() {
        _chapterInfo = result;
        isShow = true;
      });
    }
  }

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    getChaptersDetail();
  }

  void dispose() {
    super.dispose();
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: isShow
          ? Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
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
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: Row(
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
                icon: Icon(Icons.line_style),
                onPressed: () {
                  _changeLead();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

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
