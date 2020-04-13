import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_text/utils/httpHeaders.dart';

class PearVideoApi {
  final ListUrl = 'https://app.pearvideo.com/clt/jsp/v2/getCategorys.jsp';
  final HotNewsUrl = 'http://app.pearvideo.com/clt/jsp/v2/home.jsp';
  BaseOptions baseOptions;

  Future getPearVideoList() async {
    try {
      Response response = await Dio()
          .get(ListUrl);
      print(response.data);
    } catch (e) {
      print('error ============> $e');
      return null;
    }
  }
}
