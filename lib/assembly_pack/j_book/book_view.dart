import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class BookView extends StatefulWidget {
  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  Future<Uint8List> _loadFromAssets(String assetName) async {
    final bytes = await rootBundle.load(assetName);
    return bytes.buffer.asUint8List();
  }

  EpubController _epubController;

  @override
  void initState() {
    _epubController = EpubController(
      // Load document
      document: EpubReader.readBook(_loadFromAssets('assets/long14.epub')),
    );
    super.initState();
  }

  void setIndex() {

  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // Show actual chapter name
          title: EpubActualChapter(
            controller: _epubController,
            builder: (chapterValue) => Text(
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
          onChange: (EpubChapterViewValue value) {
            print(value.position);
          },
        ),
      );
}
