import 'dart:io';
import 'dart:typed_data';

import 'package:epubx/epubx.dart' as epub;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/j_book/book_helper.dart';
import 'package:flutter_text/assembly_pack/j_book/book_view.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/lock.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/widget/api_call_back.dart';

import 'book_cache.dart';

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class BookShelfWithId {
  int id;
  epub.EpubBook epubBook;
}

class _BookShelfState extends State<BookShelf> {
  final List<BookModel> _book = <BookModel>[];

  final Lock lock = Lock();

  @override
  void initState() {
    super.initState();
    loadingCallback(() => onRead());
  }

  Future<void> onRead() async {
    List<BookModel> getCache = [];
    getCache = await loadingCallback(() => BookCache.getAllCache());
    _book.addAll(getCache);
    setState(() {});
  }

  void onSelectBook() async {
    final FilePickerResult result = await loadingCallback(() =>
        FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['epub']));

    if (result != null) {
      final List<File> files = result.paths.map((String e) => File(e)).toList();
      final List<File> locateFile = await BookHelper.setAppLocateFile(files);
      final List<BookModel> books = <BookModel>[];
      for (int i = 0; i < locateFile.length; i++) {
        final Uint8List unit8 = ArrayHelper.get(locateFile, i).readAsBytesSync();
        final epub.EpubBook epubBook = await epub.EpubReader.readBook(unit8);
        final String image = await BookHelper.getCoverImageWithFile(epubBook.Content.Images.values.first.Content);
        final BookModel model = BookModel()
          ..id = epubBook.hashCode
          ..coverImage = image
          ..title = epubBook.Title
          ..bookPath = ArrayHelper.get(locateFile, i).path
          ..index = 0;
        BookCache.setCache(model);
        books.add(model);
      }
      _book.addAll(books);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('艾尔法提大图书馆某处书架'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: screenUtil.adaptive(20)),
            child: Center(
              child: InkWell(
                onTap: () {
                  onSelectBook();
                },
                child: const Text('添加'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          child: GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 250,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 1.0,
            ),
            childrenDelegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              final BookModel book = ArrayHelper.get(_book, index);;
              return InkWell(
                onLongPress: () {
                  BookCache.deleteCache(book.id);
                  _book.removeWhere((BookModel element) => element.id == book.id);
                  setState(() {});
                },
                onTap: () {
                  NavigatorUtils.pushWidget<int>(
                      context,
                      BookView(
                        book: ArrayHelper.get(_book, index),
                      )).then((int val) {
                    if (val != null) {
                      ArrayHelper.get(_book, index).index = val;
                    }
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: book.coverImage != null
                            ? Image.file(
                          File(book.coverImage),
                          fit: BoxFit.fitWidth,
                        )
                            : Container(),
                      ),
                      Container(
                        child: Text('${book.title ?? ''}'),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: _book.length ?? 0),
          ),
        ),
      ),
    );
  }
}
