import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/model/img_model.dart';
import 'package:flutter_text/widget/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetBanner extends StatefulWidget {
  final List<ImageModel> _images;
  final double height;
  final ValueChanged<int>? onTap;
  final Curve curve;
  final bool isShowIndicator;

  const WidgetBanner(
    this._images, {
    this.curve = Curves.linear,
    this.height = 200,
    this.onTap,
    this.isShowIndicator = false,
  }) : assert(_images != null);

  @override
  _WidgetBannerState createState() => _WidgetBannerState();
}

class _WidgetBannerState extends State<WidgetBanner> {
  late PageController _pageController;
  late int _currentIndex;
  Timer? _timer;

  //初始化
  @override
  void initState() {
    super.initState();
    _currentIndex = widget._images.length * 5;
    _pageController = PageController(initialPage: _currentIndex);
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]); //清除手机顶部和底部状态栏
    _initTimer();
  }

  //关闭的时候还原顶部状态栏
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    SystemChrome.setEnabledSystemUIOverlays(
        <SystemUiOverlay>[SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
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
    final int length = widget._images.length;
    return Positioned(
      bottom: 10,
      child: Row(
        children: widget._images.map((ImageModel s) {
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
    final int length = widget._images.length;
    return Container(
      height: widget.height,
      child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
              if (index == 0) {
                _currentIndex = length;
                _changePage();
              }
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onPanDown: (DragDownDetails details) {},
              onTap: () {
//                _onTapImage(index, length);
                //外部url跳转
                if (widget._images[index % length].overBrowerUrl != '') {
                  _overBrowserUrl(widget._images[index % length].overBrowerUrl);
                }
              },
              child: CustomNetWorkImage(
                widget._images[index % length].image??'',
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }

  //初始化定时任务
  void _initTimer() {
    _timer ??= Timer.periodic(const Duration(seconds: 3), (Timer t) {
      _currentIndex++;
      _pageController.animateToPage(_currentIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  //切换banner页
  void _changePage() {
    Timer(const Duration(milliseconds: 300), () {
      _pageController.jumpToPage(_currentIndex);
    });
  }

  //底部提示框
  void _onTapImage(int index, int length) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('当前page为${index % length}'),
      duration: const Duration(milliseconds: 500),
    ));
  }

  //跳转外部浏览器url
  void _overBrowserUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //跳转内部页面
  void _insideUrl(String url) {}
}
