import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/api/book.dart';
import 'package:flutter_text/model/book.dart';

void main() => runApp(ChaptersDetail());

class ChaptersDetail extends StatefulWidget {
  String link; //章节link

  ChaptersDetail({
    this.link,
  });

  ChaptersDetailState createState() => ChaptersDetailState();
}

class ChaptersDetailState extends State<ChaptersDetail> {
  ChapterInfo _chapterInfo;
  bool isShow = false;
  bool isShowBar = true;

  void getChaptersDetail() async {
    final result = await BookApi().getChaptersDetail(widget.link);
    if (result == null) {
    } else {
      setState(() {
        _chapterInfo = result;
        isShow = true;
      });
    }
  }

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    getChaptersDetail();
  }

  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isShow
          ? Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                    child: Text(
                      _chapterInfo.cpContent,
                      style: TextStyle(letterSpacing: 4.0),
                      strutStyle: StrutStyle(leading: 1.2),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    color: Color(0x40000000),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _chapterInfo.title,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: MediaQuery.of(context).size.width * 0.2,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: GestureDetector(
                        onTap: () {
                          print('11111');
                        },
                      ),
                    ))
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
