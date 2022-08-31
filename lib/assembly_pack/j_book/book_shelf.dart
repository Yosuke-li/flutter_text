import 'dart:io';
import 'dart:typed_data';

import 'package:epubx/epubx.dart' as epub;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/j_book/book_helper.dart';
import 'package:flutter_text/assembly_pack/j_book/book_view.dart';
import 'package:self_utils/utils/array_helper.dart';
import 'package:self_utils/utils/datetime_utils.dart';
import 'package:self_utils/utils/lock.dart';
import 'package:self_utils/utils/navigator.dart';
import 'package:self_utils/utils/screen.dart';
import 'package:self_utils/widget/api_call_back.dart';
import 'package:self_utils/widget/modal_utils.dart';

import 'book_cache.dart';

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class BookShelfWithId {
  int? id;
  epub.EpubBook? epubBook;
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
    getCache.sort((BookModel a, BookModel b) => (b.updateTime ?? 0) - (a.updateTime ?? 0));
    _book.addAll(getCache);
    setState(() {});
  }

  void onSelectBook() async {
    final FilePickerResult? result = await loadingCallback(() =>
        FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['epub']));

    if (result != null) {
      final List<File> files = [];
      result.paths.map((String? e) => files.add(File(e!))).toList();
      final List<File> locateFile = await BookHelper.setAppLocateFile(files);
      final List<BookModel> books = <BookModel>[];
      for (int i = 0; i < locateFile.length; i++) {
        final Uint8List? unit8 =
            ArrayHelper.get(locateFile, i)?.readAsBytesSync();
        final epub.EpubBook epubBook = await epub.EpubReader.readBook(unit8!);
        final String image = await BookHelper.getCoverImageWithFile(
            epubBook.Content?.Images?.values.first.Content);
        final BookModel model = BookModel()
          ..id = epubBook.hashCode
          ..coverImage = image
          ..title = epubBook.Title
          ..updateTime = DateTimeHelper.getLocalTimeStamp()
          ..bookPath = ArrayHelper.get(locateFile, i)?.path
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
        child: Container(
          margin: EdgeInsets.only(
            right: screenUtil.adaptive(15),
            left: screenUtil.adaptive(15),
          ),
          child: RepaintBoundary(
            child: GridView.custom(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 250,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 15.0,
              ),
              childrenDelegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                final BookModel book = ArrayHelper.get(_book, index)!;
                return InkWell(
                  onLongPress: () {
                    BookTip.showModel(context, onFunc: () {
                      BookCache.deleteCache(book.id!);
                      _book.removeWhere(
                          (BookModel element) => element.id == book.id);
                      setState(() {});
                    });
                  },
                  onTap: () {
                    NavigatorUtils.pushWidget<int>(
                        context,
                        BookView(
                          book: book,
                        )).then((int? val) {
                      if (val != null) {
                        book.index = val;
                        book.updateTime = DateTimeHelper.getLocalTimeStamp();
                        _book.sort((BookModel a, BookModel b) =>
                        (b.updateTime ?? 0) - (a.updateTime ?? 0));
                        setState(() {});
                      }
                    });
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: book.coverImage != null
                              ? Image.file(
                                  File(book.coverImage!),
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
              }, childCount: _book.length),
            ),
          ),
        ),
      ),
    );
  }
}

class BookTip {
  static Future<void> showModel(BuildContext context, {void onFunc()?}) async {
    await ModalUtils.showModal(
      context,
      modalBackgroundColor: const Color(0x00999999),
      dynamicBottom: Container(
        alignment: Alignment.center,
        child: Container(
          width: screenUtil.adaptive(820),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(screenUtil.adaptive(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: screenUtil.adaptive(60),
                ),
                alignment: Alignment.center,
                child: Text(
                  '提示',
                  style: TextStyle(
                      color: const Color(0xff404040),
                      fontSize: screenUtil.getAutoSp(45)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  top: screenUtil.adaptive(80),
                  bottom: screenUtil.adaptive(90),
                  left: screenUtil.adaptive(73),
                ),
                child: Text(
                  '是否删除这本书？',
                  style: TextStyle(
                    fontSize: screenUtil.getAutoSp(43),
                    color: const Color(0xff426ba5),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    bottom: screenUtil.adaptive(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: InkWell(
                          onTap: () {
                            NavigatorUtils.pop(context);
                          },
                          borderRadius:
                              BorderRadius.circular(screenUtil.adaptive(20)),
                          child: Container(
                            width: screenUtil.adaptive(360),
                            height: screenUtil.adaptive(110),
                            decoration: BoxDecoration(
                              color: const Color(0xb3eeeeee),
                              borderRadius: BorderRadius.circular(
                                  screenUtil.adaptive(20)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '取消',
                              style: TextStyle(
                                color: const Color(0xff878787),
                                fontSize: screenUtil.getAutoSp(43),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            NavigatorUtils.pop(context);
                            onFunc?.call();
                          },
                          borderRadius:
                              BorderRadius.circular(screenUtil.adaptive(20)),
                          child: Container(
                            width: screenUtil.adaptive(360),
                            height: screenUtil.adaptive(110),
                            decoration: BoxDecoration(
                              color: const Color(0xff577fba),
                              borderRadius: BorderRadius.circular(
                                  screenUtil.adaptive(20)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '确定',
                              style: TextStyle(
                                color: const Color(0xffffffff),
                                fontSize: screenUtil.getAutoSp(43),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
