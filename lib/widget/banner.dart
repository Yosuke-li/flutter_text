import 'dart:async';

import 'package:flutter/material.dart';

class widgetBanner extends StatefulWidget {
  final List<String> _images;
  final double height;
  final ValueChanged<int> onTap;
  final Curve curve;

  widgetBanner(
    this._images, {
    this.curve = Curves.linear,
    this.height = 200,
    this.onTap,
  }) : assert(_images != null);

  _widgetBannerState createState() => _widgetBannerState();
}

class _widgetBannerState extends State<widgetBanner> {
  PageController _pageController;
  int _currentIndex;
  Timer _timer;

  void initState() {
    super.initState();
    _currentIndex = widget._images.length * 5;
    _pageController = PageController(initialPage: _currentIndex);
    _initTimer();
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
                widget._images[index % length],
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

  _changePage() {
    Timer(Duration(milliseconds: 300), () {
      _pageController.jumpToPage(_currentIndex);
    });
  }

  _onTapImage(int index, int length) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('当前page为${index % length}'),
      duration: Duration(milliseconds: 500),
    ));
  }
}
