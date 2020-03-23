import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_text/model/book.dart';

class BookApi {
  final FuzzySearchUrl = "http://api.zhuishushenqi.com/book/fuzzy-search";
  final detailUrl = "http://api.zhuishushenqi.com/book/";
  BaseOptions baseOptions;

  //搜索小说
  Future searchBook(String key) async {
    BookResult _bookResult;
    try {
      Response response = await Dio(baseOptions).get(FuzzySearchUrl,
          options: Options(),
          queryParameters: {'query': key, 'start': 1, 'limit': 20});
      _bookResult = BookResult.fromMap(response.data);
      return _bookResult;
    } catch (e) {
      print('error ================> $e');
      return null;
    }
  }

  //小说详情
  Future getBookDetail(String id) async {
    Books _books;
    try {
      Response response =
          await Dio(baseOptions).get(detailUrl + id, options: Options());
      _books = Books.fromJson(response.data);
      return _books;
    } catch (e) {
      print('error ================> $e');
      return null;
    }
  }

  //获取小说源
  Future getBookBtoc(String id) async {
    final btocUrl = 'http://api.zhuishushenqi.com/btoc';
    BtocResult _btocResult;
    try {
      Response response = await Dio(baseOptions)
          .get(btocUrl, options: Options(), queryParameters: {
        'book': id,
        'view': 'summary',
      });
      _btocResult = BtocResult.fromMap(response.data.first);
      print(_btocResult.id);
      return getBookChapters(_btocResult.id);
    } catch (e) {
      print('error ================> $e');
      return null;
    }
  }

  //章节列表
  Future getBookChapters(String id) async {
    final chaptersUrl = 'http://api.zhuishushenqi.com/atoc/' + id;
    ChapterResult _chapterResult;
    try {
      Response response = await Dio(baseOptions)
          .get(chaptersUrl, options: Options(), queryParameters: {
        'view': 'chapters',
      });
      _chapterResult = ChapterResult.fromMap(response.data);
      return _chapterResult;
    } catch (e) {
      print('error ================> $e');
      return null;
    }
  }

  //章节内容
  Future getChaptersDetail(String link) async {
    print("getChaptersDetail ===== $link");
    try {
      Response response =
          await Dio(baseOptions).get(link, options: Options());
      print(response.data);
    } catch (e) {
      print('error ================> $e');
      return null;
    }
  }
}
