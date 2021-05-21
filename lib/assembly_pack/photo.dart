import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

void main() => runApp(PickImage());

class PickImage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片，拍照'),
        centerTitle: true,
      ),
      body: PickImageDemo(),
    );
  }
}

class PickImageDemo extends StatefulWidget {
  PickImageState createState() => PickImageState();
}

class PickImageState extends State<PickImageDemo> {
  final List<File> _imageList = <File>[];

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: FlatButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.photo_camera),
                              title: new Text("Camera"),
                              onTap: ()  {
                                _getImage(0);
                              },
                            ),
                            new ListTile(
                              leading: new Icon(Icons.photo_library),
                              title: new Text("Gallery"),
                              onTap: ()  {
                                _getImage(1);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                );
              },
              child: Text('图片'),
            ),
          ),
          Container(
            child: FlatButton(
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
    final List<AssetEntity> images = await AssetPicker.pickAssets(context);
    if(images != null) {
      final List<File> list = <File>[];
      for (int i = 0; i< images.length; i++) {
        final File file = await ArrayHelper.get(images, i).file;
        list.add(file);
      }
      setState(() {
        _imageList.addAll(list);
      });
    }
  }

  Future<void> _getImage(_photoIndex) async {
    Navigator.of(context).pop();
    final image = await ImagePickerSaver.pickImage(
        source: _photoIndex == 0 ? ImageSource.camera : ImageSource.gallery, maxWidth: 1024.0, maxHeight: 1024.0);

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