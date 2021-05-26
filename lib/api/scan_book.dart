import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_text/model/scan_book.dart';
import 'package:flutter_text/utils/dio/dio_helper.dart';

class ScanBookApi {
  final String url = 'http://49.234.70.238:9001/book/worm/isbn'; //私人API
  final String aliUrl =
      'http://jisuisbn.market.alicloudapi.com/isbn/query'; //阿里云Api 限制30次 6/30
  final BaseOptions baseOptions = BaseOptions();
  final String appCode = '853da7ee8c334ac0b293bbd812473b42';

  Future<ScanBookPModel> isbnGetBookDetailP(String isbn) async {
    try {
      ScanBookPModel _scanBook;
      final Response res = await Request.get(url, params: {'isbn': isbn});
      _scanBook = ScanBookPModel.fromJson(res.data['data'][0]);
      return _scanBook;
    } catch (e) {
      print('IsbnGetBookDetailP error = $e');
      rethrow;
    }
  }

  Future<ScanBookAModel> isbnGetBookDetailA(String isbn) async {
    try {
      ScanBookAModel _scanABook;
      final Response res = await Request.get(aliUrl,
          params: {'isbn': isbn}, token: 'APPCODE $appCode');
      print(res.data['result']);
      _scanABook = ScanBookAModel.fromJson(res.data['result']);
      return _scanABook;
    } catch (e) {
      print('IsbnGetBookDetailP error = ${e}');
      rethrow;
    }
  }
}
