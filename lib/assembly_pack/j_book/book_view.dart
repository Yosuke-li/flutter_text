import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_text/assembly_pack/j_book/book_cache.dart';
import 'package:flutter_text/utils/date_format.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/widget/api_call_back.dart';

class BookView extends StatefulWidget {
  BookModel book;

  BookView({this.book}) : assert(book != null);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  EpubController _epubController;
  int index = 0;

  @override
  void initState() {
    _epubController = EpubController(
      // Load document
      document: EpubReader.readBook(widget.book.book),
    );
    setState(() {});
    super.initState();
    loadingCallback(
      () => Future<void>.delayed(const Duration(milliseconds: 200)).then(
        (_) => setIndex(),
      ),
    );
  }

  void setIndex() {
    if (widget.book.index > 0) {
      Future<void>.delayed(const Duration(milliseconds: 16)).then((value) =>
          _epubController.scrollTo(
              index: widget.book.index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart));
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          // Show actual chapter name
          title: EpubActualChapter(
            controller: _epubController,
            builder: (EpubChapterViewValue chapterValue) => Text(
              'Chapter ${chapterValue.chapter.Title ?? ''}',
              textAlign: TextAlign.start,
            ),
          ),
        ),
        // Show table of contents
        drawer: Drawer(
          child: EpubReaderTableOfContents(
            controller: _epubController,
          ),
        ),
        // Show epub document
        body: EpubView(
          controller: _epubController,
        ),
      ),
      onWillPop: () async {
        BookCache().updateIndex(
            id: widget.book.id,
            index: _epubController.currentValue.position.index);
        NavigatorUtils.pop(context, results: _epubController.currentValue.position.index);
        return true;
      });
}
