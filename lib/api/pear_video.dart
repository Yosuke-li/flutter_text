import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_text/model/pear_video.dart';
import 'package:self_utils/init.dart';
import 'package:self_utils/utils/httpHeaders.dart';

class PearVideoApi {
  final ListUrl = 'https://app.pearvideo.com/clt/jsp/v2/getCategorys.jsp';  //获取类别
  final HotNewsUrl = 'https://app.pearvideo.com/clt/jsp/v2/home.jsp';  //获取热点
  final getListData =
      'https://app.pearvideo.com/clt/jsp/v2/getCategoryConts.jsp'; //获取该类别下的数据
  final getContentUrl = 'https://app.pearvideo.com/clt/jsp/v2/content.jsp';//获取详情
  late BaseOptions baseOptions;

  Future getPearVideoList() async {
    final headers = await getHeaders();
    try {
      List<ContList> _contList = [];
      ContList cont;
      Response response =
          await Request.get(HotNewsUrl, header: headers);
      List list = response.data['dataList'][0]['contList'];
      _contList = list.map((e) {
        cont = ContList.fromJson(e);
        cont.nodeInfo = NodeInfo.fromJson(cont.mNodeInfo as Map<String, dynamic>);
        return cont;
      }).toList();
      return _contList;
    } catch (e) {
      print('error ============> $e');
      rethrow;
    }
  }

  Future getCategoryList() async {
    final headers = await getHeaders();
    try {
      List<Category> categoryList = [];
      Response response =
          await Request.get(ListUrl, header: headers);
      print(response.data['categoryList']);
      List list = response.data['categoryList'];
      categoryList = list.map((e) => Category.fromJson(e)).toList();
      return categoryList;
    } catch (e) {
      print('error ============> $e');
      rethrow;
    }
  }

  Future getCategoryDataList(int page, String categoryId) async {
    final headers = await getHeaders();
    try {
      List<HotList> _hotList = [];
      HotList hot;
      final Response response = await Request.post(getListData,
          header: headers,
          data: {
            'hotPageidx': page,
            'categoryId': categoryId,
          });
      final List list = response.data['hotList'];
      _hotList = list.map((e) {
        hot = HotList.fromJson(e);
        hot.nodeInfo = NodeInfo.fromJson(hot.mNodeInfo as Map<String, dynamic>);
        return hot;
      }).toList();

      List<Future<Function?>> updateList = []; //强制等待
      _hotList.map((el) async =>
        updateList.add((e) async {
           e.videos = await getContentDataList(el.contId!);
        }(el)
      )).toList();
      await Future.wait(updateList);

      return _hotList;
    } catch (e) {
      print('error ============> $e');
      rethrow;
    }
  }

  Future getContentDataList(String contId) async {
    final headers = await getHeaders();
    try {
      Videos _videos;
      Response response = await Request.post(getContentUrl,
          header: headers,
          params: {
            'contId': contId,
          });
      _videos = Videos.fromJson(response.data['content']['videos'][0]);
      return _videos;
    } catch (e) {
      print('error ============> $e');
      rethrow;
    }
  }

  Future getHeaders() async {
    final Map<String, String> headers = <String, String>{};
    headers['X-Channel-Code'] = 'official';
    headers['X-Client-Agent'] = 'Xiaomi';
    headers['X-Client-Hash'] = '2f3d6ffkda95dlz2fhju8d3s6dfges3t';
    headers['X-Client-ID'] = '123456789123456';
    headers['X-Client-Version'] = '2.3.2';
    headers['X-Long-Token'] = '';
    headers['X-Platform-Type'] = '0';
    headers['X-Platform-Version'] = '5.0';
    headers['X-Serial-Num'] =
        '${DateTime.now().millisecondsSinceEpoch ~/ 1000}';
    headers['X-User-ID'] = '';
    return headers;
  }
}
