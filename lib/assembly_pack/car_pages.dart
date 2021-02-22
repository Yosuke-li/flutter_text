import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/model/a_z_model.dart';
import 'package:flutter_text/widget/a_to_z_list/az_common.dart';
import 'package:flutter_text/widget/a_to_z_list/az_listview.dart';
import 'package:flutter_text/widget/a_to_z_list/index_bar.dart';
import 'package:lpinyin/lpinyin.dart';

class CarModelsPage extends StatefulWidget {
  @override
  _CarModelsPageState createState() => _CarModelsPageState();
}

class _CarModelsPageState extends State<CarModelsPage> {
  List<AtoZInfo> contactList = [];

  double susItemHeight = 24;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    rootBundle.loadString('assets/data/car_models.json').then((String value) {
      List list = json.decode(value);
      list.forEach((v) {
        contactList.add(AtoZInfo.fromJson(v));
      });
//      contactList = contactList.reversed.toList();
//      log('$contactList');
      _handleList(contactList);
    });
  }

  void _handleList(List<AtoZInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(contactList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contactList);

    // add header.
    contactList.insert(0, AtoZInfo(name: 'header', tagIndex: '选'));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Car models',
          style: TextStyle(color: Color(0xFF171717)),
        ),
      ),
      body: AzListView(
        data: contactList,
        itemCount: contactList.length,
        itemBuilder: (BuildContext context, int index) {
          AtoZInfo model = contactList[index];
          return ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.0),
                color: model.bgColor,
                image: null,
              ),
              child: model.iconData == null
                  ? null
                  : Icon(
                model.iconData,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(model.name),
            onTap: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('onItemClick : ${model.name}'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          );
        },
        susItemHeight: susItemHeight,
        susItemBuilder: (BuildContext context, int index) {
          AtoZInfo model = contactList[index];
          if ('选' == model.getSuspensionTag()) {
            return Container();
          }
          return Container(
            height: susItemHeight,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 16.0),
            color: const Color(0xFFF3F4F5),
            alignment: Alignment.centerLeft,
            child: Text(
              '${model.getSuspensionTag()}',
              softWrap: false,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(0xFF666666),
              ),
            ),
          );;
        },
        indexBarData: kIndexBarData,
        indexBarOptions: const IndexBarOptions(
          needRebuild: true,
          selectTextStyle: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          selectItemDecoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xFF333333)),
          indexHintWidth: 96,
          indexHintHeight: 97,
          indexHintAlignment: Alignment.centerRight,
          indexHintTextStyle: TextStyle(fontSize: 24.0, color: Colors.white),
          indexHintOffset: Offset(-30, 0),
        ),
      ),
    );
  }
}
