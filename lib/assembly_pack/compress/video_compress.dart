import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:self_utils/utils/log_utils.dart';
import 'package:self_utils/utils/toast_utils.dart';
import 'package:self_utils/widget/api_call_back.dart';
import 'package:self_utils/widget/video_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_compress_ds/video_compress_ds.dart';

class VideoCompressPage extends StatefulWidget {
  @override
  _VideoCompressState createState() => _VideoCompressState();
}

class _VideoCompressState extends State<VideoCompressPage> {
  File? _file;
  File? _videoFile;

  @override
  void initState() {
    super.initState();
  }

  //选择视频
  void _getVideo() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _file = File(result.files.first.path!);
      });
    }
  }

  //压缩
  void _compress() async {
    final MediaInfo? result = await loadingCallback(
      () => VideoCompress.compressVideo(
        _file!.path,
        quality: VideoQuality.DefaultQuality,
      ),
    );

    if (result != null) {
      setState(() {
        _videoFile = result.file!;
      });
    }
  }

  void saveToLocal() async {
    try {
      await ImageGallerySaver.saveFile(_videoFile!.path);
      ToastUtils.showToast(msg: '文件已保存到$_videoFile');
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    VideoCompress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    if (_file != null)
                      Container(
                        child: VideoPlayerPage(
                          file: _file,
                          autoPlay: false,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text(
                        '视频大小：${_file != null ? (_file!.readAsBytesSync().lengthInBytes / 1024).toStringAsFixed(2) : 0} KB')
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _getVideo();
                      },
                      child: const Text('选择视频'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _compress();
                      },
                      child: const Text('压缩视频'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveToLocal();
                      },
                      child: const Text('保存到本地'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    if (_videoFile != null)
                      Container(
                        child: VideoPlayerPage(
                          file: _videoFile,
                          autoPlay: false,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text(
                        '压缩后视频大小：${_videoFile != null ? (_videoFile!.readAsBytesSync().lengthInBytes / 1024).toStringAsFixed(2) : 0} KB')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
