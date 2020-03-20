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
}
