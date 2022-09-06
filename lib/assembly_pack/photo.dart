import 'dart:io';
import 'package:flutter/material.dart';
import 'package:self_utils/utils/array_helper.dart';
import 'package:self_utils/utils/navigator.dart';
import 'package:self_utils/utils/screen.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PickImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片，拍照'),
        centerTitle: true,
      ),
      body: PickImageDemo(),
    );
  }
}

class PickImageDemo extends StatefulWidget {
  @override
  PickImageState createState() => PickImageState();
}

class PickImageState extends State<PickImageDemo> {
  final List<File> _imageList = <File>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: screenUtil.adaptive(250),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _getImage(0);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: const Icon(Icons.photo_camera),),
                                    const Text('Camera')
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              width: 1,
                              height: 28,
                              color: const Color(0xffE6E6E6),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _getImage(1);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: const Icon(Icons.photo_library),),
                                    const Text('Gallery')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: const Text('图片'),
            ),
          ),
          Container(
            child: FloatingActionButton(
              onPressed: () {
                _getWechatPicker();
              },
              child: const Text('相册多选图片'),
            ),
          ),
          Wrap(
            spacing: 10,
            children: _getImageList(),
          )
        ],
      ),
    );
  }

  Future<void> _getWechatPicker() async {
    final List<AssetEntity>? images = await AssetPicker.pickAssets(context);
    if (images != null) {
      final List<File> list = <File>[];
      for (int i = 0; i < images.length; i++) {
        final File? file = await ArrayHelper.get(images, i)?.file;
        if (file != null) {
          list.add(file);
        }
      }
      setState(() {
        _imageList.addAll(list);
      });
    }
  }

  Future<void> _getImage(int _photoIndex) async {
    Navigator.of(context).pop();
    final File image = await ImagePickerSaver.pickImage(
        source: _photoIndex == 0 ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1024.0,
        maxHeight: 1024.0);

    //没有选择图片或者没有拍照
    if (image != null) {
      setState(() {
        _imageList.add(image);
      });
    }
    print(_imageList);
  }

  //图片列表的刻画
  List<Widget> _getImageList() {
    return _imageList.map((img) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Image.file(
              img,
              fit: BoxFit.cover,
              width: 100.0,
              height: 70.0,
            ),
            Positioned(
              right: 5.0,
              top: 5.0,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    color: Colors.lightBlue,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _imageList.remove(img);
                  });
                },
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
