import 'dart:io';
import 'dart:typed_data';

import 'package:epubx/epubx.dart' as epub;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/assembly_pack/canvas_paint.dart';
import 'package:flutter_text/assembly_pack/j_book/book_view.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/lock.dart';
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
  final List<BookShelfWithId> bookShelfList = <BookShelfWithId>[];

  final Lock lock = Lock();

  @override
  void initState() {
    super.initState();
    loadingCallback(() => onRead());
  }

  Future<void> onRead() async {
    List<BookModel> getCache = [];
    List<BookShelfWithId> bookShelfs = <BookShelfWithId>[];
    getCache = await loadingCallback(() => BookCache().getAllCache());
    await loadingCallback(
      () => lock.mutex(() async {
        for (int i = 0; i < getCache.length; i++) {
          final BookModel cache = ArrayHelper.get(getCache, i);
          final epub.EpubBook epubBook =
              await epub.EpubReader.readBook(cache.book);
          bookShelfs.add(BookShelfWithId()
            ..id = cache.id
            ..epubBook = epubBook);
        }
      }),
    );
    _book.addAll(getCache);
    bookShelfList.addAll(bookShelfs);
    setState(() {});
  }

  void onSelectBook() async {
    final FilePickerResult result = await loadingCallback(() =>
        FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['EPUB']));

    if (result != null) {
      final List<File> files = result.paths.map((String e) => File(e)).toList();
      final List<BookModel> books = <BookModel>[];
      final List<BookShelfWithId> bookShelfs = <BookShelfWithId>[];
      for (int i = 0; i < files.length; i++) {
        final Uint8List unit8 = ArrayHelper.get(files, i).readAsBytesSync();
        final epub.EpubBook epubBook = await epub.EpubReader.readBook(unit8);
        final BookModel model = BookModel()
          ..id = epubBook.hashCode
          ..book = unit8
          ..index = 0;
        final BookShelfWithId bookShelfWithId = BookShelfWithId()
          ..id = epubBook.hashCode
          ..epubBook = epubBook;
        BookCache().setCache(model);
        books.add(model);
        bookShelfs.add(bookShelfWithId);
      }
      _book.addAll(books);
      bookShelfList.addAll(bookShelfs);
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
        child: GridView.custom(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          childrenDelegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            final int id = ArrayHelper.get(_book, index).id;
            final book = bookShelfList
                .firstWhere((BookShelfWithId element) => element.id == id,
                    orElse: (null))
                ?.epubBook;
            return InkWell(
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
                      child: book.CoverImage != null ? Image.memory(
                        book.CoverImage?.getBytes(),
                        width: 150,
                        height: 250,
                        fit: BoxFit.fitWidth,
                      ) : Container(),
                    ),
                    Container(
                      child: Text('${book.Title ?? ''}'),
                    ),
                  ],
                ),
              ),
            );
          }, childCount: _book.length ?? 0),
        ),
      ),
    );
  }
}
