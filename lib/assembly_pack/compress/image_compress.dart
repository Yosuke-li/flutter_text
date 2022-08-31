import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_text/init.dart';
import 'package:self_utils/utils/compress.dart';
import 'package:image_picker_saver/image_picker_saver.dart';

class ImageCompressPage extends StatefulWidget {
  @override
  _ImageCompressState createState() => _ImageCompressState();
}

class _ImageCompressState extends State<ImageCompressPage> {
  File? _file;
  File? _compressImage;

  int? width;
  int? height;

  //获取图片
  Future<void> _getImage() async {
    final File image = await ImagePickerSaver.pickImage(
        source: ImageSource.gallery, maxWidth: 1024.0, maxHeight: 1024.0);
    final Image pimage = Image.file(image);

    //获取图片file格式的长宽
    pimage.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      Log.info(info.image.height);
      Log.info(info.image.width);
      setState(() {
        width = info.image.width;
        height = info.image.height;
      });
    }));

    //没有选择图片或者没有拍照
    if (image != null) {
      setState(() {
        _file = image;
        _compressImage = null;
      });
    }
  }

  Future<void> _compress() async {
    if (_file == null) {
      return;
    }
    final File? result = await ImageCompressUtil.imageCompressAndGetFile(_file!);

    if (result != null) {
      setState(() {
        _compressImage = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
                        child: Image.file(
                          _file!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text('图片尺寸：width ${width ?? 0} height ${height ?? 0}'),
                    Text(
                        '图片大小：${_file != null ? ((_file?.readAsBytesSync().lengthInBytes ?? 0) / 1024).toStringAsFixed(2) : 0} KB')
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
                        _getImage();
                      },
                      child: const Text('选择图片'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _compress();
                      },
                      child: const Text('压缩图片'),
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
                    if (_compressImage != null)
                      Container(
                        child: Image.file(
                          _compressImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text(
                        '压缩后图片大小：${_compressImage != null ? ((_compressImage?.readAsBytesSync().lengthInBytes ?? 0) / 1024).toStringAsFixed(2) : 0} KB')
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
