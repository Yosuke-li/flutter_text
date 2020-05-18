import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_text/model/pear_video.dart';
import 'package:flutter_text/utils/httpHeaders.dart';

class PearVideoApi {
  final ListUrl = 'https://app.pearvideo.com/clt/jsp/v2/getCategorys.jsp';  //获取类别
  final HotNewsUrl = 'http://app.pearvideo.com/clt/jsp/v2/home.jsp';  //获取热点
  final getListData =
      'http://app.pearvideo.com/clt/jsp/v2/getCategoryConts.jsp'; //获取该类别下的数据
  final getContentUrl = 'http://app.pearvideo.com/clt/jsp/v2/content.jsp';//获取详情
  BaseOptions baseOptions;

  Future getPearVideoList() async {
    final headers = await getHeaders();
    try {
      List<ContList> _contList = [];
      ContList cont;
      Response response =
          await Dio().get(HotNewsUrl, options: Options(headers: headers));
      List list = response.data['dataList'][0]['contList'];
      _contList = list.map((e) {
        cont = ContList.fromJson(e);
        cont.nodeInfo = NodeInfo.fromJson(cont.mNodeInfo);
        return cont;
      }).toList();
      return _contList;
    } catch (e) {
      print('error ============> $e');
      return null;
    }
  }

  Future getCategoryList() async {
    final headers = await getHeaders();
    try {
      List<Category> categoryList = [];
      Response response =
          await Dio().get(ListUrl, options: Options(headers: headers));
      print(response.data['categoryList']);
      List list = response.data['categoryList'];
      categoryList = list.map((e) => Category.fromJson(e)).toList();
      return categoryList;
    } catch (e) {
      print('error ============> $e');
      return null;
    }
  }

  Future getCategoryDataList(int page, String categoryId) async {
    final headers = await getHeaders();
    try {
      List<HotList> _hotList = [];
      HotList hot;
      Response response = await Dio().post(getListData,
          options: Options(headers: headers),
          queryParameters: {
            'hotPageidx': page,
            'categoryId': categoryId,
          });
      List list = response.data['hotList'];
      _hotList = list.map((e) {
        hot = HotList.fromJson(e);
        hot.nodeInfo = NodeInfo.fromJson(hot.mNodeInfo);
        return hot;
      }).toList();

      List<Future<Function>> updateList = []; //强制等待
      _hotList.map((e) async =>
        updateList.add((e) async {
          e.videos = await getContentDataList(e.contId);
        }(e)
      )).toList();
      await Future.wait(updateList);
      return _hotList;
    } catch (e) {
      print('error ============> $e');
      return null;
    }
  }

  Future getContentDataList(String contId) async {
    final headers = await getHeaders();
    try {
      Videos _videos;
      Response response = await Dio().post(getContentUrl,
          options: Options(headers: headers),
          queryParameters: {
            'contId': contId,
          });
      _videos = Videos.fromJson(response.data['content']['videos'][0]);
      return _videos;
    } catch (e) {
      print('error ============> $e');
      return null;
    }
  }

  Future getHeaders() async {
    var headers = Map<String, String>();
    headers['X-Channel-Code'] = 'official';
    headers['X-Client-Agent'] = 'Xiaomi';
    headers['X-Client-Hash'] = '2f3d6ffkda95dlz2fhju8d3s6dfges3t';
    headers['X-Client-ID'] = '123456789123456';
    headers['X-Client-Version'] = '2.3.2';
    headers['X-Long-Token'] = '';
    headers['X-Platform-Type'] = '0';
    headers['X-Platform-Version'] = '5.0';
    headers['X-Serial-Num'] =
        '${(DateTime.now().millisecondsSinceEpoch / 1000).toInt()}';
    headers['X-User-ID'] = '';
    return headers;
  }
}
