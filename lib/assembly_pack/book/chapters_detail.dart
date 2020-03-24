import 'package:flutter/material.dart';
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

  void getChaptersDetail() async {
    final result = await BookApi().getChaptersDetail(widget.link);
    if (result == null) {
    } else {
      setState(() {
        _chapterInfo = result;
      });
    }
  }

  void initState() {
    super.initState();
    getChaptersDetail();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Text(
            _chapterInfo.cpContent,
            style: TextStyle(letterSpacing: 4.0),
            strutStyle: StrutStyle(leading: 1.2),
          ),
        ),
      ),
    );
  }
}
