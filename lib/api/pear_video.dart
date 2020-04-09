import 'dart:io';

import 'package:dio/dio.dart';

class PearVideoApi {
  final ListUrl = 'https://app.pearvideo.com/clt/jsp/v2/getCategorys.jsp';
  final HotNewsUrl = 'http://app.pearvideo.com/clt/jsp/v2/home.jsp';
  BaseOptions baseOptions;

  Future getPearVideoList() async {
    try {
      Response response = await Dio(baseOptions)
          .get(ListUrl, options: Options());
      print(response.data);
    } catch (e) {
      print('error ============> $e');
      return null;
    }
  }
}
