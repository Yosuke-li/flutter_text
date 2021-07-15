import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/datetime_utils.dart';

class BookModel {
  int id;
  String bookPath;
  int index;
  int updateTime;
  String title;
  String coverImage;

  BookModel({this.bookPath, this.index, this.id, this.title, this.coverImage, this.updateTime});

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map['bookPath'] = bookPath;
    map['updateTime'] = updateTime;
    map['title'] = title;
    map['coverImage'] = coverImage;
    map['id'] = id;
    map['index'] = index;

    return map;
  }

  //todo Uint8List.fromList((json['book'] as List<dynamic>).cast<int>().toList());
  BookModel.fromJson(dynamic json) {
    bookPath = json['bookPath'];
    index = json['index'];
    coverImage = json['coverImage'];
    updateTime = json['updateTime'];
    title = json['title'];
    id = json['id'];
  }

  @override
  String toString() {
    return 'BookModel[bookPath=$bookPath, index=$index, id=$id, coverImage=$coverImage, title=$title, updateTime=$updateTime]';
  }

  static List<BookModel> listFromJson(List<dynamic> json) {
    return json == null
        ? <BookModel>[]
        : json.map((e) => BookModel.fromJson(e)).toList();
  }
}

class BookCache {
  static const String _key = 'book_cache';

  static Future<void> clear() async {
    final String hasKey = LocateStorage.getOneKey(_key);
    LocateStorage.clean(key: hasKey);
  }

  @override
  static Future<void> deleteCache(int id) async {
    final List<BookModel> allCache = await getAllCache();
    allCache.removeWhere((BookModel element) => element.id == id);
    LocateStorage.setString(_key,
        jsonEncode(allCache));
  }

  @override
  static Future<List<BookModel>> getAllCache() async {
    List<BookModel> result = <BookModel>[];
    final String json =
    LocateStorage.getString(_key);
    print(json);
    if (json != null && json.isNotEmpty == true) {
      result = BookModel.listFromJson(jsonDecode(json));
    }
    return result;
  }

  @override
  static Future<BookModel> getCache(String title) async {
    final List<BookModel> allCache = await getAllCache();
    BookModel result;
    for (int i = 0; i<allCache.length; i++) {
      if (ArrayHelper.get(allCache, i).title == title) {
        result = ArrayHelper.get(allCache, i);
        break;
      }
    }
    return result;
  }

  @override
  static Future<void> setCache(BookModel data) async {
    List<BookModel> newList = <BookModel>[];
    final List<BookModel> allCache = await getAllCache();
    allCache.add(data);
    newList = ArrayHelper.unique(listData: allCache, getKey: (BookModel model) => model.id);
    LocateStorage.setString(_key ,
        jsonEncode(newList));
  }

  static Future<void> updateIndex({int id, int index}) async {
    List<BookModel> newList = <BookModel>[];
    final List<BookModel> allCache = await getAllCache();
    final BookModel book = allCache.firstWhere((BookModel element) => element.id == id, orElse: () => null);
    book.index = index;
    book.updateTime = DateTimeHelper.getLocalTimeStamp();
    allCache.add(book);
    newList = ArrayHelper.unique(listData: allCache, getKey: (BookModel model) => model.id);
    LocateStorage.setString(_key ,
        jsonEncode(newList));
  }
}