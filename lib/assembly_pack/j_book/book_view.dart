import 'dart:io';
import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:epub_view/src/data/models/chapter_view_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/j_book/book_cache.dart';
import 'package:flutter_text/global/global.dart';
import 'package:self_utils/utils/navigator.dart';
import 'package:self_utils/utils/screen.dart';
import 'package:self_utils/widget/api_call_back.dart';

class BookView extends StatefulWidget {
  final BookModel book;

  const BookView({required this.book});

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  late EpubController _epubController;
  int index = 0;

  @override
  void initState() {
    final Uint8List bytes = File(widget.book.bookPath!).readAsBytesSync();
    _epubController = EpubController(
      // Load document
      document: EpubReader.readBook(bytes),
    );
    setState(() {});
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 200)).then(
          (_) => setIndex(),
    );
  }

  void setIndex() async {
    if ((widget.book.index ?? 0) > 0) {
      await loadingCallback(
            () =>
            Future<void>.delayed(const Duration(milliseconds: 16)).then(
                  (_) =>
                  _epubController.scrollTo(
                      index: widget.book.index ?? 0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutQuart),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) =>
      WillPopScope(
          child: Scaffold(
            appBar: GlobalStore.isMobile ? AppBar(
              // Show actual chapter name
              title: EpubViewActualChapter(
                controller: _epubController,
                builder: (EpubChapterViewValue? chapterValue) =>
                    Text(
                      '${chapterValue?.chapter?.Title ?? ''}',
                      textAlign: TextAlign.start,
                    ),
              ),
            ) : null,
            drawer: Drawer(
              child: EpubViewTableOfContents(
                controller: _epubController,
              ),
            ),
            // Show epub document
            body: RepaintBoundary(
                child: Stack(
                  children: <Widget>[
                    EpubView(
                      controller: _epubController,
                    ),
                    Positioned(
                      bottom: screenUtil.adaptive(20),
                      right: screenUtil.adaptive(20),
                      child: RepaintBoundary(
                        child: IndexPage(epubController: _epubController,),
                      ),
                    ),
                  ],
                )),
          ),
          onWillPop: () async {
            BookCache.updateIndex(
                id: widget.book.id,
                index: _epubController.currentValue?.position.index);
            NavigatorUtils.pop(context,
                results: _epubController.currentValue?.position.index);
            return true;
          });
}

class IndexPage extends StatefulWidget {
  final EpubController epubController;

  const IndexPage({required this.epubController});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<IndexPage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    listenerPage();
  }

  void listenerPage() {
    if (widget.epubController != null) {
      widget.epubController.currentValueListenable.addListener(() {
        index =
            widget.epubController.currentValue?.position.index ?? 0;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        child: Text('进度：$index'),
      ),
    );
  }
}