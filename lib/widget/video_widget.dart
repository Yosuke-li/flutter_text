import 'dart:async';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart'; // 引入官方插件

class VideoPlayerText extends StatefulWidget {
  const VideoPlayerText({
    this.url, // 当前需要播放的地址
    this.file, //浏览本地视频的地址
    this.width, // 播放器尺寸（大于等于视频播放区域）
    this.height,
    this.title = '', // 视频需要显示的标题
  });

  // 视频地址
  final String url;
  final File file;

  // 视频尺寸比例
  final double width;
  final double height;

  // 视频标题
  final String title;

  @override
  State<VideoPlayerText> createState() {
    return _VideoPlayerTextState();
  }
}

// 指示video资源是否加载完成，加载完成后会获得总时长和视频长宽比等信息
class _VideoPlayerTextState extends State<VideoPlayerText> {
  bool _videoInit = false; // video控件管理器
  VideoPlayerController _controller; // 记录video播放进度
  Duration _position = const Duration(seconds: 0); //播放时长
  Duration _totalDuration = const Duration(seconds: 0); //总时长
  double movePan = 0.0; // 偏移量累计总和
  // 记录播放控件ui是否显示(进度条，播放按钮，全屏按钮等等)
  Timer _timer; // 计时器，用于延迟隐藏控件ui
  bool _hidePlayControl = true; // 控制是否隐藏控件ui
  double _playControlOpacity = 0; // 通过透明度动画显示/隐藏控件ui
  // 记录是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  bool isFinish = false; //是否播放完成

  //内容区
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.black,
      child: widget.file != null || widget.url != null
          ? Stack(
              // 因为控件ui和视频是重叠的，所以要用定位了
              children: <Widget>[
                _topBar(context), //头部栏
                GestureDetector(
                  // 手势组件
                  onTap: () {
                    // 点击显示/隐藏控件ui
                    _togglePlayControl();
                  },
                  //双击暂停/播放
                  onDoubleTap: () {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  },
                  onHorizontalDragStart: _onHorizontalDragStart,
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: _videoInit
                      ? Center(
                          child: AspectRatio(
                            // 加载url或者file成功时，根据视频比例渲染播放器
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        )
                      : const Center(
                          // 没加载完成时显示转圈圈loading
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
                _bottomBar(context), //底部栏
              ],
            )
          : const Center(
              // 判断是否传入了url或者file，没有的话显示"暂无视频信息"
              child: Text(
                '暂无视频信息',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }

  //头部控制栏
  Widget _topBar(BuildContext context) {
    return Offstage(
      offstage: _hidePlayControl,
      child: AnimatedOpacity(
        opacity: _playControlOpacity,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // 来点黑色到透明的渐变优雅一下
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Color.fromRGBO(0, 0, 0, .7),
                Color.fromRGBO(0, 0, 0, .1)
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //在最上层或者不是横屏则隐藏按钮
              ModalRoute.of(context).isFirst && !_isFullScreen
                  ? Container()
                  : IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: backPress),
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //底部控制栏
  Widget _bottomBar(BuildContext context) {
    return Positioned(
      // 需要定位
      left: 0,
      bottom: 0,
      child: Offstage(
        // 控制是否隐藏
        offstage: _hidePlayControl,
        child: AnimatedOpacity(
          // 加入透明度动画
          opacity: _playControlOpacity,
          duration: const Duration(milliseconds: 300),
          child: Container(
            // 底部控件的容器
            width: widget.width,
            height: 40,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                // 来点黑色到透明的渐变优雅一下
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Color.fromRGBO(0, 0, 0, .7),
                  Color.fromRGBO(0, 0, 0, .1)
                ],
              ),
            ),
            child: _videoInit
                ? Row(
                    // 加载完成时才渲染,flex布局
                    children: <Widget>[
                      IconButton(
                        // 播放按钮
                        padding: EdgeInsets.zero,
                        iconSize: 26,
                        icon: Icon(
                          // 根据控制器动态变化播放图标还是暂停
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            // 同样的，点击动态播放或者暂停
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : isFinish
                                    ? _urlChange()
                                    : _controller.play();
                            _startPlayControlTimer(); // 操作控件后，重置延迟隐藏控件的timer
                          });
                        },
                      ),
                      Flexible(
                        // 相当于前端的flex: 1
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true, // 允许手势操作进度条
                          padding: const EdgeInsets.all(0),
                          colors: VideoProgressColors(
                            // 配置进度条颜色，也是video_player现成的，直接用
                            playedColor: Theme.of(context).primaryColor,
                            // 已播放的颜色
                            bufferedColor:
                                const Color.fromRGBO(255, 255, 255, .5),
                            // 缓存中的颜色
                            backgroundColor: const Color.fromRGBO(
                                255, 255, 255, .2), // 为缓存的颜色
                          ),
                        ),
                      ),
                      Container(
                        // 播放时间
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          '${DateUtil.formatDateMs(
                            _position?.inMilliseconds,
                            format: 'mm:ss',
                          )}/${DateUtil.formatDateMs(
                            _totalDuration?.inMilliseconds,
                            format: 'mm:ss',
                          )}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        iconSize: 23,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        iconSize: 26,
                        icon: Icon(
                          // 根据当前屏幕方向切换图标
                          _isFullScreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // 点击切换是否全屏
                          _toggleFullScreen();
                        },
                      ),
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  //返回按钮
  void backPress() {
    print(_isFullScreen);
    // 如果是全屏，点击返回键则关闭全屏，如果不是，则系统返回键
    if (_isFullScreen) {
      _toggleFullScreen();
    } else if (ModalRoute.of(context).isFirst) {
      SystemNavigator.pop();
    } else {
      Navigator.pop(context);
    }
  }

  //初始化
  @override
  void initState() {
    _urlChange(); // 初始进行一次url加载
    super.initState();
  }

  //数据变化的时候
  @override
  void didUpdateWidget(VideoPlayerText oldWidget) {
    if (oldWidget.url != widget.url || oldWidget.file != widget.file) {
      _urlChange(); // url变化时重新执行一次url加载
    }
    super.didUpdateWidget(oldWidget);
  }

  //销毁的时候
  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      // 惯例。组件销毁时清理下
      _controller.removeListener(_videoListener);
      _controller.dispose();
      _controller = null;
    }
  }

  //改变视频url和file
  void _urlChange() {
    if ((widget.url == null || widget.url == '') &&
        (widget.file == null || widget.file == '')) return;
    if (_controller != null) {
      // 如果控制器存在，清理掉重新创建
      _controller.removeListener(_videoListener);
      _controller.dispose();
      _controller = null;
    }
    // 重置组件参数
    _hidePlayControl = true;
    _videoInit = false;
    _position = const Duration(seconds: 0);
    // 加载network的url，也支持本地文件，自行阅览官方api
    setUrl(true);
    setState(() {});
  }

  void setUrl(bool isPlay) {
    if (widget.url == null) {
      _controller = VideoPlayerController.file(widget.file)
        ..initialize().then((_) {
          // 加载资源完成时，监听播放进度，并且标记_videoInit=true加载完成
          _controller.addListener(_videoListener);
          setState(() {
            _videoInit = true;
          });
          //加载资源完成后 自动播放
          if (isPlay == true) _controller.play();
        });
    } else {
      _controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          // 加载资源完成时，监听播放进度，并且标记_videoInit=true加载完成
          _controller.addListener(_videoListener);
          setState(() {
            _videoInit = true;
          });
          //加载资源完成后 自动播放
          if (isPlay == true) _controller.play();
        });
    }
  }

  //水平滑动开始
  void _onHorizontalDragStart(DragStartDetails details) async {
    if (!_videoInit) {
      return;
    }
    // 获取当前时间
    _position = _controller.value.position;
  }

  //滑动更新/快进/快退
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_videoInit) {
      return;
    }
    // 累计计算偏移量
    movePan += details.delta.dx / 10;
    final double value = _setHorizontalValue();
    // 用百分比计算出当前的秒数
    final String currentSecond = DateUtil.formatDateMs(
      (value * _controller.value.duration.inMilliseconds).toInt(),
      format: 'mm:ss',
    );
    ToastUtils.showToast(msg: currentSecond);
  }

  //滑动结束
  void _onHorizontalDragEnd(DragEndDetails details) async {
    if (!_videoInit) {
      return;
    }
    final double value = _setHorizontalValue();
    final int current =
        (value * _controller.value.duration.inMilliseconds).toInt();
    await _controller.seekTo(Duration(milliseconds: current)); //进度跳转
  }

  //进度条变化
  double _setHorizontalValue() {
    // 进度条百分控制
    final double valueHorizontal =
        double.parse((movePan / context.size.width).toStringAsFixed(2));
    // 当前进度条百分比
    final double currentValue =
        _position.inMilliseconds / _controller.value.duration.inMilliseconds;
    double value =
        double.parse((currentValue + valueHorizontal).toStringAsFixed(2));
    if (value >= 1.00) {
      value = 1.00;
    } else if (value <= 0.00) {
      value = 0.00;
    }
    return value;
  }

  //视频监听（进度条）
  void _videoListener() async {
    final Duration res =
        await _controller?.position ?? const Duration(seconds: 0);
    if (res >= _controller?.value?.duration ?? const Duration(seconds: 0)) {
      _controller.pause();
      _controller.seekTo(const Duration(seconds: 0));
    }
    _position = res;
    _totalDuration = _controller.value.duration;
    setState(() {});
  }

  //视频控件显示隐藏控制
  void _togglePlayControl() {
    setState(() {
      if (_hidePlayControl) {
        // 如果隐藏则显示
        _hidePlayControl = false;
        _playControlOpacity = 1;
        _startPlayControlTimer(); // 开始计时器，计时后隐藏
      } else {
        // 如果显示就隐藏
        if (_timer != null) _timer.cancel(); // 有计时器先移除计时器
        _playControlOpacity = 0;
        Future<void>.delayed(const Duration(milliseconds: 2000))
            .whenComplete(() {
          _hidePlayControl = true; // 延迟300ms(透明度动画结束)后，隐藏
        });
      }
    });
  }

  //控件隐藏计时器
  void _startPlayControlTimer() {
    // 计时器，用法和前端js的大同小异
    if (_timer != null) _timer.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      // 延迟3s后隐藏
      setState(() {
        _playControlOpacity = 0;
        Future<void>.delayed(const Duration(milliseconds: 2000))
            .whenComplete(() {
          _hidePlayControl = true;
        });
      });
    });
  }

  //全屏
  void _toggleFullScreen() {
    setState(() {
      if (_isFullScreen) {
        // 如果是全屏就切换竖屏
        OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
      } else {
        OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
      }
      _startPlayControlTimer(); // 操作完控件开始计时隐藏
    });
  }
}
