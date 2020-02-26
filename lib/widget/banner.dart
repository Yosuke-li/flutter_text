import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_text/api/img_data.dart';
import 'package:flutter/services.dart';

class widgetBanner extends StatefulWidget {
  final List<ImageData> _images;
  final double height;
  final ValueChanged<int> onTap;
  final Curve curve;
  final bool isShowIndicator;

  widgetBanner(this._images, {
    this.curve = Curves.linear,
    this.height = 200,
    this.onTap,
    this.isShowIndicator = false,
  }) : assert(_images != null);

  _widgetBannerState createState() => _widgetBannerState();
}

class _widgetBannerState extends State<widgetBanner> {
  PageController _pageController;
  int _currentIndex;
  Timer _timer;

  //初始化
  void initState() {
    super.initState();
    _currentIndex = widget._images.length * 5;
    _pageController = PageController(initialPage: _currentIndex);
    SystemChrome.setEnabledSystemUIOverlays([]);                    //清除手机顶部和底部状态栏
    _initTimer();
  }

  //关闭的时候还原顶部状态栏
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildPageView(),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    var length = widget._images.length;
    return Positioned(
      bottom: 10,
      child: Row(
        children: widget._images.map((s) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ClipOval(
              child: Container(
                width: 8,
                height: 8,
                color: s == widget._images[_currentIndex % length]
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPageView() {
    var length = widget._images.length;
    return Container(
      height: widget.height,
      child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              if (index == 0) {
                _currentIndex = length;
                _changePage();
              }
            });
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onPanDown: (details) {},
              onTap: () {
//                _onTapImage(index, length);
              },
              child: Image.network(
                widget._images[index % length].image,
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }

  //初始化定时任务
  _initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 3), (t) {
        _currentIndex++;
        _pageController.animateToPage(_currentIndex,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      });
    }
  }

  //切换bannner页
  _changePage() {
    Timer(Duration(milliseconds: 300), () {
      _pageController.jumpToPage(_currentIndex);
    });
  }

  //底部提示框
  _onTapImage(int index, int length) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('当前page为${index % length}'),
      duration: Duration(milliseconds: 500),
    ));
  }
}
