import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(PickImage());

class PickImage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: PickImageDemo(),
    );
  }
}

class PickImageDemo extends StatefulWidget {
  PickImageState createState() => PickImageState();
}

class PickImageState extends State<PickImageDemo> {
  List _imageList = List<File> ();

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
          Wrap(
            spacing: 10,
            children: _getImageList(),
          )
        ],
      ),
    );
  }

  Future _getImage(_photoIndex) async {
    Navigator.of(context).pop();
    var image = await ImagePicker.pickImage(
        source: _photoIndex == 0 ? ImageSource.camera : ImageSource.gallery);

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