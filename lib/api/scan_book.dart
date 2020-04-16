import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_text/model/scan_book.dart';

class ScanBookApi {
  final url = 'http://49.234.70.238:9001/book/worm/isbn';             //私人API
  final aliUrl = 'http://jisuisbn.market.alicloudapi.com/isbn/query';   //阿里云Api 限制30次 6/30
  final BaseOptions baseOptions = BaseOptions();
  final appCode = '853da7ee8c334ac0b293bbd812473b42';

  Future IsbnGetBookDetailP(isbn) async {
    try {
      ScanBookPModel _scanBook;
      Response res = await Dio(baseOptions)
          .get(url, options: Options(), queryParameters: {'isbn': isbn});
      _scanBook = ScanBookPModel.fromJson(res.data['data'][0]);
      return _scanBook;
    } catch (e) {
      print('IsbnGetBookDetailP error = ${e}');
      return null;
    }
  }

  Future IsbnGetBookDetailA(isbn) async {
    try {
      ScanBookAModel _scanABook;
      Response res = await Dio(baseOptions)
          .get(aliUrl, options: Options(headers: {HttpHeaders.authorizationHeader: "APPCODE $appCode"}), queryParameters: {'isbn': isbn});
      print(res.data['result']);
      _scanABook = ScanBookAModel.fromJson(res.data['result']);
      return _scanABook;
    } catch (e) {
      print('IsbnGetBookDetailP error = ${e}');
      return null;
    }
  }
}
