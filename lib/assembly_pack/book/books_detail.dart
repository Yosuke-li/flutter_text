import 'package:flutter/material.dart';
import 'package:flutter_text/api/book.dart';
import 'package:flutter_text/model/book.dart';

void main() => runApp(BooksDetail());

class BooksDetail extends StatefulWidget {
  final String id;

  BooksDetail({this.id});

  BooksDetailState createState() => BooksDetailState();
}

class BooksDetailState extends State<BooksDetail> {
  Books _books;
  bool isShowPage = false;

  //获取详情
  void getBooksDetail() async {
    final result = await BookApi().getBookDetail(widget.id);
    if (result != null) {
      setState(() {
        _books = result;
        isShowPage = true;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void initState() {
    getBooksDetail();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: isShowPage
            ? NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 400.0, //展开高度
                      floating: false, //是否随滑动隐藏标题
                      pinned: true, //是否固定在顶部
                      flexibleSpace: FlexibleSpaceBar(
                        //可折叠的应用栏
                        centerTitle: true,
                        title: Container(
                          child: Text(
                            _books.title,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Center(
                  child: Container(),
                ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
