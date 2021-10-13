import 'package:flutter/material.dart';
import 'package:flutter_text/api/book.dart';
import 'package:flutter_text/assembly_pack/book/books_detail.dart';
import 'package:flutter_text/model/book.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SearchBook extends StatefulWidget {

  @override
  SearchBookState createState() => SearchBookState();
}

class SearchBookState extends State<SearchBook> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController(); //listview的控制器
  bool hasData = false;
  BookResult _bookResult;
  int page = 0;
  int limit = 25;
  List<Books> _books;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData(_controller.text);
      }
    });
  }

  void getData(String val) async {
    _bookResult = await BookApi().searchBook(val, (page * limit) + 1, limit);
    _books.addAll(_bookResult.books);
    setState(() {
      page = page + 1;
      _books = _books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: _searchWidget(context),
          ),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: _books != null
                ? AnimationLimiter(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => BooksDetail(
                                                id: _books[index].id)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15),
                                    child: Text(_books[index].title,),
                                  ),
                                ),
                              ),
                            ));
                      },
                      itemCount: _books.length,
                    ),
                  )
                : Center(
                    child: Text('暂无数据'),
                  )));
  }

  Widget _searchWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _controller,
              onChanged: (val) {
                setState(() {
                  page = 0;
                  limit = 25;
                  _books = [];
                });
                getData(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
