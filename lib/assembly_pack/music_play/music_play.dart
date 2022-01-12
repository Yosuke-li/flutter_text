import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_text/assembly_pack/music_play/music_helper.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/widget/api_call_back.dart';

class MusicPlayPage extends StatefulWidget {
  @override
  _MusicPlayState createState() => _MusicPlayState();
}

class _MusicPlayState extends State<MusicPlayPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(child: _Page());
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  AudioPlayer _audioPlayer = AudioPlayer();
  String name;
  int times;
  int currentTime;

  AudioPlayerState _state;

  @override
  void initState() {
    super.initState();
  }

  void select() async {
    final FilePickerResult result = await loadingCallback(
      () => FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.audio,
      ),
    );

    if (result != null) {
      if (result.isSinglePick == true) {
        _audioPlayer = AudioPlayer();
        final r = await _audioPlayer.play(ArrayHelper.get(result.files, 0).path,
            isLocal: true);
        Log.info(r);
        _audioPlayer.onPlayerStateChanged.listen((event) {
          Log.info('onPlayerStateChanged $event');
          _state = event;
          setState(() {});
        });
        _audioPlayer.onDurationChanged.listen((Duration duration) {
          times = duration.inSeconds;
          setState(() {});
        });
        _audioPlayer.onAudioPositionChanged.listen((event) {
          currentTime = event.inSeconds;
          setState(() {});
        });
        name = ArrayHelper.get(result.names, 0);
        setState(() {});
      }
    }
  }

  //暂停
  void startOrPause() async {
    if (_state == AudioPlayerState.PAUSED) {
      await _audioPlayer.resume();
    } else {
      await _audioPlayer.pause();
    }
  }

  //拖拽进度条
  void onSeekChange(int sec) async {
    await _audioPlayer.seek(Duration(seconds: sec));
  }

  @override
  void dispose() {
    if (mounted) {
      _audioPlayer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NeumorphicBackground(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 14),
              _buildTopBar(context),
              const SizedBox(height: 80),
              _buildImage(context),
              const SizedBox(height: 30),
              _buildTitle(context),
              const SizedBox(height: 30),
              _buildSeekBar(context),
              const SizedBox(height: 30),
              _buildControlsBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              padding: const EdgeInsets.all(18.0),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: const NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Icon(
                Icons.navigate_before,
                color: _iconsColor(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Now Playing',
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              padding: const EdgeInsets.all(18.0),
              onPressed: () {
                select();
              },
              style: const NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Icon(
                Icons.file_upload,
                color: _iconsColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Container(
          height: 200,
          width: 200,
          child: Image.asset(
            'images/timg3.jpg',
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('${name ?? ' '}',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: NeumorphicTheme.defaultTextColor(context))),
        const SizedBox(
          height: 4,
        ),
        Text("The Weeknd",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: NeumorphicTheme.defaultTextColor(context))),
      ],
    );
  }

  Widget _buildSeekBar(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${DateTimeHelper.secToMusicTime(currentTime) ?? 0}',
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${DateTimeHelper.secToMusicTime(times) ?? 0}',
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    )),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            NeumorphicSlider(
              height: 8,
              min: 0,
              max: times?.toDouble() ?? 100,
              value: currentTime?.toDouble() ?? 0,
              onChanged: (double value) {
                onSeekChange(value.toInt());
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildControlsBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NeumorphicButton(
          padding: const EdgeInsets.all(18.0),
          onPressed: () {},
          style: const NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: Icon(
            Icons.skip_previous,
            color: _iconsColor(),
          ),
        ),
        const SizedBox(width: 12),
        NeumorphicButton(
          padding: const EdgeInsets.all(24.0),
          onPressed: () {
            startOrPause();
          },
          style: const NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: Icon(
            _state == AudioPlayerState.PAUSED ? Icons.play_arrow : Icons.pause,
            size: 42,
            color: _iconsColor(),
          ),
        ),
        const SizedBox(width: 12),
        NeumorphicButton(
          padding: const EdgeInsets.all(18.0),
          onPressed: () {},
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: Icon(
            Icons.skip_next,
            color: _iconsColor(),
          ),
        ),
      ],
    );
  }

  Color _iconsColor() {
    final theme = NeumorphicTheme.of(context);
    if (theme.isUsingDark) {
      return theme.current.accentColor;
    } else {
      return null;
    }
  }
}
