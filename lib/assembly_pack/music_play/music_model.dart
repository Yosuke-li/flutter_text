import 'dart:convert';

import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/utils/array_helper.dart';

class MusicModel {
  String? name;
  int? id;
  String? path;

  MusicModel({this.name, this.id, this.path});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['name'] = name;
    map['id'] = id;
    map['path'] = path;

    return map;
  }

  //todo Uint8List.fromList((json['book'] as List<dynamic>).cast<int>().toList());
  MusicModel.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    path = json['path'];
  }

  @override
  String toString() {
    return 'MusicModel[name=$name, id=$id, path=$path]';
  }

  static List<MusicModel> listFromJson(List<dynamic> json) {
    return json == null
        ? <MusicModel>[]
        : json.map((e) => MusicModel.fromJson(e)).toList();
  }
}

// 本地缓存
class MusicCache {
  static const String _key = 'music_cache';

  static Future<void> clear() async {
    final String hasKey = LocateStorage.getOneKey(_key)!;
    LocateStorage.clean(key: hasKey);
  }

  static Future<void> deleteCache(int id) async {
    final List<MusicModel> allCache = await getAllCache();
    allCache.removeWhere((MusicModel element) => element.id == id);
    LocateStorage.setString(_key,
        jsonEncode(allCache));
  }

  static Future<List<MusicModel>> getAllCache() async {
    List<MusicModel> result = <MusicModel>[];
    final String json =
    LocateStorage.getString(_key)!;
    print(json);
    if (json != null && json.isNotEmpty == true) {
      result = MusicModel.listFromJson(jsonDecode(json));
    }
    return result;
  }

  static Future<MusicModel?> getCache(String name) async {
    final List<MusicModel> allCache = await getAllCache();
    MusicModel? result;
    for (int i = 0; i<allCache.length; i++) {
      if (ArrayHelper.get(allCache, i)?.name == name) {
        result = ArrayHelper.get(allCache, i);
        break;
      }
    }
    return result;
  }

  static Future<void> setCache(MusicModel data) async {
    List<MusicModel> newList = <MusicModel>[];
    final List<MusicModel> allCache = await getAllCache();
    allCache.add(data);
    newList = ArrayHelper.unique(listData: allCache, getKey: (MusicModel model) => model.id);
    LocateStorage.setString(_key ,
        jsonEncode(newList));
  }
}