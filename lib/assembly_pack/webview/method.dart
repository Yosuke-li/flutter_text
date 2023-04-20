import 'dart:convert';

import 'package:flutter_text/init.dart';

class WebModel {
  String? title;
  String? url;

  WebModel({this.url, this.title});

  WebModel.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String;
    title = json['title'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    return data;
  }

  static List<WebModel> listFromJson(List<dynamic>? json) {
    return json == null
        ? <WebModel>[]
        : json.map((e) => WebModel.fromJson(e)).toList();
  }
}

class WebCollect {
  static String key = 'web_collect';

  static List<WebModel> _webs = [];

  static List<WebModel> getAllWebs() {
    final String? res = LocateStorage.getString(key);
    Log.info(res ?? '');
    if (res != null) {
      _webs = WebModel.listFromJson(jsonDecode(res));
    }
    return _webs;
  }

  static void setWebs(WebModel val) {
    final String? res = LocateStorage.getString(key);
    Log.info(res ?? '');
    List<WebModel> webs = [];
    if (res != null) {
      webs = WebModel.listFromJson(jsonDecode(res));
    }
    if (!webs.any((WebModel element) => element.url == val.url)) {
      webs.add(val);
      LocateStorage.setString(key, jsonEncode(webs));
    }
  }

  static void clear() {
    LocateStorage.clean(key: key);
  }
}
