import 'package:flutter/material.dart';
import 'package:flutter_text/api/book.dart';
import 'package:flutter_text/utils/date_format.dart';

void main() => runApp(ChaptersDetail());

class ChaptersDetail extends StatefulWidget {
  String link;                    //章节link

  ChaptersDetail({
    this.link,
  });

  ChaptersDetailState createState() => ChaptersDetailState();
}

class ChaptersDetailState extends State<ChaptersDetail> {
  void getChaptersDetail() async {
    final result = await BookApi().getChaptersDetail(widget.link);
  }

  void initState() {
    super.initState();
    getChaptersDetail();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
