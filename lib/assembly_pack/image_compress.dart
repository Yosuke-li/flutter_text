import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/compress.dart';
import 'package:image_picker_saver/image_picker_saver.dart';

class ImageCompressPage extends StatefulWidget {
  @override
  _ImageCompressState createState() => _ImageCompressState();
}

class _ImageCompressState extends State<ImageCompressPage> {
  File _file;
  File _compressImage;

  Future<void> _getImage() async {
    final File image = await ImagePickerSaver.pickImage(
        source: ImageSource.gallery, maxWidth: 1024.0, maxHeight: 1024.0);

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
    final File result = await ImageCompressUtil.imageCompressAndGetFile(_file);

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
                          _file,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Text(
                        '图片大小：${_file != null ? (_file.readAsBytesSync().lengthInBytes / 1024).toStringAsFixed(2) : 0} KB')
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
                          _compressImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Text(
                        '压缩后图片大小：${_compressImage != null ? (_compressImage.readAsBytesSync().lengthInBytes / 1024).toStringAsFixed(2) : 0} KB')
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
