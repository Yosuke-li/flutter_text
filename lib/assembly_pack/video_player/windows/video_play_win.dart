import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:self_utils/utils/datetime_utils.dart';
import 'package:self_utils/utils/log_utils.dart';
import 'package:self_utils/utils/screen.dart';
import 'package:self_utils/utils/toast_utils.dart';
import 'package:self_utils/utils/utils.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart'; // 引入官方插件

class VideoPlayWinPage extends StatefulWidget {
  const VideoPlayWinPage({
    Key? key,
    this.file,
    this.width,
    this.height,
    this.autoPlay = true,
    this.title = '',
  }) : super(key: key);

  // 视频地址
  final File? file;

  // 视频尺寸比例
  final double? width;
  final double? height;

  // 视频标题
  final String? title;

  final bool? autoPlay;

  @override
  State<VideoPlayWinPage> createState() => _VideoPlayWinPageState();
}

class _VideoPlayWinPageState extends State<VideoPlayWinPage> {
  GlobalKey anchorKey = GlobalKey();

  bool _videoInit = false; // video控件管理器
  VideoPlayerController? _controller; // 记录video播放进度
  Duration _position = const Duration(seconds: 0); //播放时长
  Duration _totalDuration = const Duration(seconds: 0); //总时长
  double movePan = 0.0; // 偏移量累计总和
  // 记录播放控件ui是否显示(进度条，播放按钮，全屏按钮等等)
  Timer? _timer; // 计时器，用于延迟隐藏控件ui
  bool _hidePlayControl = true; // 控制是否隐藏控件ui
  double _playControlOpacity = 0; // 通过透明度动画显示/隐藏控件ui
  // 记录是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  double speed = 1.0; //默认

  Completer<void>? _completer;

  //内容区
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.black,
      child: widget.file != null
          ? MouseRegion(
              onHover: (PointerHoverEvent event) {
                _togglePlayControl();
              },
              child: Column(
                children: <Widget>[
                  _topBar(context),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _togglePlayControl();
                      },
                      onDoubleTap: () {
                        _controller?.value.isPlaying == true
                            ? _controller?.pause()
                            : _controller?.play();
                      },
                      onHorizontalDragStart: _onHorizontalDragStart,
                      onHorizontalDragUpdate: _onHorizontalDragUpdate,
                      onHorizontalDragEnd: _onHorizontalDragEnd,
                      child: _videoInit
                          ? Center(
                              child: AspectRatio(
                                // 加载url或者file成功时，根据视频比例渲染播放器
                                aspectRatio:
                                    _controller?.value.aspectRatio ?? 0,
                                child: VideoPlayer(_controller!),
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
                  ),
                  _bottomBar(context),
                ],
              ),
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
            alignment: Alignment.center,
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
            child: Text(
              widget.title ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }

  //底部控制栏
  Widget _bottomBar(BuildContext context) {
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
                        _controller?.value.isPlaying == true
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          // 同样的，点击动态播放或者暂停
                          _controller?.value.isPlaying == true
                              ? _controller?.pause()
                              : _controller?.play();
                          _startPlayControlTimer(); // 操作控件后，重置延迟隐藏控件的timer
                        });
                      },
                    ),
                    Flexible(
                      child: VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: true, // 允许手势操作进度条
                        padding: const EdgeInsets.all(0),
                        colors: VideoProgressColors(
                          // 配置进度条颜色，也是video_player现成的，直接用
                          playedColor: Theme.of(context).primaryColor,
                          // 已播放的颜色
                          bufferedColor:
                              const Color.fromRGBO(255, 255, 255, .5),
                          // 缓存中的颜色
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, .2), // 为缓存的颜色
                        ),
                      ),
                    ),
                    Container(
                      // 播放时间
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${DateTimeHelper.secToMSTime(
                          _position.inSeconds,
                        )}/${DateTimeHelper.secToMSTime(
                          _totalDuration.inSeconds,
                        )}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      key: anchorKey,
                      onTapDown: (TapDownDetails details) {
                        _startPlayControlTimer();
                        _showMenu(context, details);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Center(
                          child: Text(
                            '${speed == 1.0 ? '倍速' : 'x $speed'}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
    );
  }

  PopupMenuButton<double> _popMenu() {
    return PopupMenuButton<double>(
      itemBuilder: (BuildContext context) => _getPopupMenu(context),
      onSelected: (double value) {
        setSpeed(value);
      },
    );
  }

  void _showMenu(BuildContext context, TapDownDetails detail) {
    final RenderBox renderBox =
        anchorKey.currentContext?.findRenderObject() as RenderBox;
    final Offset offset =
        renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    final RelativeRect position = RelativeRect.fromLTRB(
        detail.globalPosition.dx, //取点击位置坐弹出x坐标
        offset.dy * 0.8, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
        detail.globalPosition.dx,
        0);
    final PopupMenuButton<double> pop = _popMenu();
    showMenu<double>(
      context: context,
      color: const Color(0xD90000000),
      items: pop.itemBuilder(context),
      position: position, //弹出框位置
    ).then((double? newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled!();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected!(newValue);
    });
  }

  List<PopupMenuEntry<double>> _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry<double>>[
      PopupMenuItem<double>(
        value: 0.5,
        height: screenUtil.adaptive(80),
        child: const Text('x0.5'),
        textStyle: const TextStyle(color: Colors.white),
      ),
      PopupMenuItem<double>(
        value: 0.75,
        height: screenUtil.adaptive(80),
        child: const Text('x0.75'),
        textStyle: const TextStyle(color: Colors.white),
      ),
      PopupMenuItem<double>(
        value: 1.0,
        height: screenUtil.adaptive(80),
        child: const Text('x1.0'),
        textStyle: const TextStyle(color: Colors.white),
      ),
      PopupMenuItem<double>(
        value: 1.25,
        height: screenUtil.adaptive(80),
        child: const Text('x1.25'),
        textStyle: const TextStyle(color: Colors.white),
      ),
      PopupMenuItem<double>(
        value: 1.5,
        height: screenUtil.adaptive(80),
        child: const Text('x1.5'),
        textStyle: const TextStyle(color: Colors.white),
      ),
      PopupMenuItem<double>(
        value: 2.0,
        height: screenUtil.adaptive(80),
        child: const Text('x2.0'),
        textStyle: const TextStyle(color: Colors.white),
      ),
    ];
  }

  //设置倍速
  void setSpeed(double s) {
    _controller?.setPlaybackSpeed(s);
    setState(() {
      speed = s;
    });
  }

  //初始化
  @override
  void initState() {
    super.initState();
    _urlChange();
  }

  //数据变化的时候
  @override
  void didUpdateWidget(VideoPlayWinPage oldWidget) {
    if (oldWidget.file != widget.file) {
      _urlChange(); // url变化时重新执行一次url加载
    }
    super.didUpdateWidget(oldWidget);
  }

  //销毁的时候
  @override
  void dispose() {
    if (_controller != null) {
      // 惯例。组件销毁时清理下
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
      _controller = null;
    }
    if (_timer != null) _timer?.cancel();
    super.dispose();
  }

  //改变视频url和file
  void _urlChange() {
    if ((widget.file == null || widget.file == '')) return;
    if (_controller != null) {
      // 如果控制器存在，清理掉重新创建
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
    }
    // 重置组件参数
    _hidePlayControl = true;
    _videoInit = false;
    _position = const Duration(seconds: 0);
    // 加载network的url，也支持本地文件，自行阅览官方api
    setUrl(widget.autoPlay ?? false);
    setState(() {});
  }

  /// [Utils.debounce]防抖加入能优化dispose后再进入listener的情况
  void setUrl(bool isPlay) async {
    _controller = VideoPlayerController.file(widget.file!);
    _controller?.addListener(() => _videoListener());
    await _controller?.initialize();
    _videoInit = true;
    //加载资源完成后 自动播放
    if (isPlay == true) _controller?.play();
    setState(() {});
  }

  //水平滑动开始
  void _onHorizontalDragStart(DragStartDetails details) async {
    if (!_videoInit) {
      return;
    }
    // 获取当前时间
    _position = _controller?.value.position ?? const Duration(seconds: 0);
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
    final String? currentSecond = DateTimeHelper.datetimeFormat(
      (value * (_controller?.value.duration.inMilliseconds ?? 0)).toInt(),
      'mm:ss',
    );
    ToastUtils.showToast(msg: currentSecond ?? '');
  }

  //滑动结束
  void _onHorizontalDragEnd(DragEndDetails details) async {
    if (!_videoInit) {
      return;
    }
    final double value = _setHorizontalValue();
    final int current =
        (value * (_controller?.value.duration.inMilliseconds ?? 0)).toInt();
    await _controller?.seekTo(Duration(milliseconds: current)); //进度跳转
    setState(() {});
  }

  //进度条变化
  double _setHorizontalValue() {
    // 进度条百分控制
    final double valueHorizontal =
        double.parse((movePan / (context.size?.width ?? 1)).toStringAsFixed(2));
    // 当前进度条百分比
    final double currentValue = _position.inMilliseconds /
        (_controller?.value.duration.inMilliseconds ?? 1);
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
    if (_controller == null || _controller?.value.hasError == true) {
      return;
    }
    final Duration? res = await _controller?.position;
    if (res != null &&
        res >= (_controller?.value.duration ?? const Duration(seconds: 0))) {
      await _controller?.pause();
      await _controller?.seekTo(const Duration(seconds: 0));
    }
    _position = res!;
    _totalDuration = _controller?.value.duration ?? const Duration(seconds: 0);
    setState(() {});
  }

  //视频控件显示隐藏控制
  void _togglePlayControl() {
    _hidePlayControl = false;
    _playControlOpacity = 1;
    _startPlayControlTimer();
    setState(() {});
  }

  //控件隐藏计时器
  void _startPlayControlTimer() {
    if (_timer != null) _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _playControlOpacity = 0;
          Future<void>.delayed(const Duration(milliseconds: 2000))
              .whenComplete(() {
            _hidePlayControl = true;
          });
        });
      }
    });
  }

  //全屏
  void _toggleFullScreen() {
    setState(() {
      _startPlayControlTimer(); // 操作完控件开始计时隐藏
    });
  }
}
