import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_text/model/translate.dart';

class translateApi {
  final String translateUrl = 'http://fy.iciba.com/ajax.php';
  final BaseOptions baseOptions = BaseOptions();

  Future getTrans(String form, String to, String word) async {
    Content content;
    ContentE contentE;
    try {
      Response response = await Dio(baseOptions).get(translateUrl,
          options: Options(),
          queryParameters: {'a': 'fy', 'f': form, 't': to, 'w': word});
      var json_s = json.decode(response.data);
      if(json_s['status'] == 1) {
        content = Content.formJson(json_s['content']);
        return {'Content': content, 'status': 1};
      } else if (json_s['status'] == 0) {
        contentE = ContentE.formJson(json_s['content']);
        return {'Content': contentE, 'status': 0};
      }
    } catch (e) {
      print('error ==========> $e');
      rethrow;
    }
  }
}
