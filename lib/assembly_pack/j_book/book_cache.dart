import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/utils/array_helper.dart';

class BookModel {
  int id;
  String bookPath;
  int index;

  BookModel({this.bookPath, this.index, this.id});

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map['bookPath'] = bookPath;
    map['id'] = id;
    map['index'] = index;

    return map;
  }

  //todo Uint8List.fromList((json['book'] as List<dynamic>).cast<int>().toList());
  BookModel.fromJson(dynamic json) {
    bookPath = json['bookPath'];
    index = json['index'];
    id = json['id'];
  }

  @override
  String toString() {
    return 'BookModel[bookPath=$bookPath, index=$index, id=$id]';
  }

  static List<BookModel> listFromJson(List<dynamic> json) {
    return json == null
        ? <BookModel>[]
        : json.map((e) => BookModel.fromJson(e)).toList();
  }
}

class BookCache {
  static const String _key = 'book_cache';

  @override
  Future<void> deleteCache(int id) async {
    final List<BookModel> allCache = await getAllCache();
    allCache.removeWhere((BookModel element) => element.id == id);
    LocateStorage.setStringWithExpire(_key,
        jsonEncode(allCache), const Duration(days: 1));
  }

  @override
  Future<List<BookModel>> getAllCache() async {
    List<BookModel> result = <BookModel>[];
    final String json =
    LocateStorage.getStringWithExpire(_key);
    print(json);
    if (json != null && json.isNotEmpty == true) {
      result = BookModel.listFromJson(jsonDecode(json));
    }
    return result;
  }

  @override
  Future<BookModel> getCache(String title) async {
    final List<BookModel> allCache = await getAllCache();
    BookModel result;
    for (int i = 0; i<allCache.length; i++) {
      final Uint8List byte = File(ArrayHelper.get(allCache, i).bookPath).readAsBytesSync();
      final EpubBook book = await EpubReader.readBook(byte);
      if (book.Title == title) {
        result = ArrayHelper.get(allCache, i);
        break;
      }
    }
    return result;
  }

  @override
  Future<void> setCache(BookModel data) async {
    List<BookModel> newList = <BookModel>[];
    final List<BookModel> allCache = await getAllCache();
    allCache.add(data);
    newList = ArrayHelper.unique(listData: allCache, getKey: (BookModel model) => model.id);
    LocateStorage.setStringWithExpire(_key ,
        jsonEncode(newList), const Duration(days: 1));
  }

  Future<void> updateIndex({int id, int index}) async {
    List<BookModel> newList = <BookModel>[];
    final List<BookModel> allCache = await getAllCache();
    final book = allCache.firstWhere((BookModel element) => element.id == id, orElse: () => null);
    book.index = index;
    allCache.add(book);
    newList = ArrayHelper.unique(listData: allCache, getKey: (BookModel model) => model.id);
    LocateStorage.setStringWithExpire(_key ,
        jsonEncode(newList), const Duration(days: 1));
  }
}