import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:core';

class GetDisplayMediaPage extends StatefulWidget {
  const GetDisplayMediaPage({super.key});

  @override
  State<GetDisplayMediaPage> createState() => _GetUserMediaPageState();
}

class _GetUserMediaPageState extends State<GetDisplayMediaPage> {
  late MediaStream _stream; //媒体流
  final _loadRender = RTCVideoRenderer(); //视频渲染对象
  bool _isOpen = false; //是否打开音视频

  @override
  void initState() {
    super.initState();
    _init();
  }

  //初始化
  Future<void> _init() async {
    await _loadRender.initialize(); //渲染对象的初始化
  }

  Future<void> _open() async {
    Map<String, dynamic> mediaConstraints = {
      'audio': false,
      'video': true
    };

    try {
      _stream = await navigator.mediaDevices.getDisplayMedia(mediaConstraints);
      _loadRender.srcObject = _stream;
    } catch (err) {
      rethrow;
    }

    if (mounted) {
      _isOpen = true;
      setState(() {});
    }
  }

  Future<void> _close() async {
    try {
      await _stream.dispose();
      _loadRender.srcObject = null;
    } catch(err) {
      rethrow;
    }

    if (!mounted) return;
    setState(() {
      _isOpen = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_isOpen) {
      _close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //手机屏幕旋转builder
      body: OrientationBuilder(
        builder: (context, _) {
          return Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: RTCVideoView(_loadRender),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isOpen ? _close : _open,
        child: Icon(_isOpen ? Icons.close : Icons.add),
      ),
    );
  }
}
