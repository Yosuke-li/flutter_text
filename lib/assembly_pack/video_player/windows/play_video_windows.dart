import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:self_utils/utils/lock.dart';

import '../../../init.dart';
import 'helper.dart';
import 'video_play_win.dart';

class PlayVideoWindows extends StatefulWidget {
  const PlayVideoWindows({Key? key}) : super(key: key);

  @override
  State<PlayVideoWindows> createState() => _PlayVideoWindowsState();
}

class _PlayVideoWindowsState extends State<PlayVideoWindows> {
  List<WinVideoModel> videoList = [];
  WinVideoModel? current;
  double _height = 0;

  final Lock _lock = Lock();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final List<WinVideoModel> res = WinVideoCache.getLocalVideos();
    videoList = res;
    setState(() {});
  }

  void _pickerVideo() async {
    try {
      _lock.lock();
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false, //todo之后拓展
      );
      if (result != null) {
        final File res = await WinVideoHelper.setLocalVideoPath(
            file: File(result.files.first.path!),
            name: result.files.first.name);

        final WinVideoModel videoModel = WinVideoModel()
          ..name = result.files.first.name
          ..id = result.files.first.name.hashCode
          ..path = res.path;

        videoList.add(videoModel);
        current = videoModel;
        setState(() {});
        WinVideoCache.setLocalVideos(videoModel);
      }
      _lock.unlock();
    } catch (err) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: RepaintBoundary(
                        child: VideoPlayWinPage(
                          key: current == null
                              ? null
                              : Key(current.hashCode.toString()),
                          title: current?.name ?? '',
                          file: current == null ? null : File(current!.path!),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: _height,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                color: Colors.amberAccent,
                                width: 160,
                                height: 200,
                                child: InkWell(
                                    onTap: () {
                                      _height = 0;
                                      setState(() {});
                                    },
                                    child: Text('封面')),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text('标题:'),
                                        ),
                                        Container(
                                          child: Text(''),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: const Text('简介:'),
                                        ),
                                        Container(
                                          child: Text(''),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 240,
              color: Colors.white,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: videoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final WinVideoModel res =
                            ArrayHelper.get(videoList, index)!;
                            return InkWell(
                              onTap: () {
                                if (current != res) {
                                  current = res;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.only(
                                    left: 20, right: 15),
                                color: current == res
                                    ? Colors.lightBlueAccent
                                    : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        res.name ?? '',
                                        style: TextStyle(
                                            color: current == res
                                                ? Colors.white
                                                : null),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          videoList.remove(res);
                                          WinVideoCache.delete(res);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 18,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!_lock.isUsing()) {
                          _pickerVideo();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 30, left: 30, bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              '添加视频',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
