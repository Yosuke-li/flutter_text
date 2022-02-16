import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/management/function_page/manage/manage_list.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/widget/management/common/view_key.dart';
import 'package:flutter_text/widget/management/widget/custom_expansion_tile.dart';
import 'dart:math' as math;

import 'editor.dart';

class Tool extends StatefulWidget {
  final EditorController controller;

  const Tool({Key key, this.controller}) : super(key: key);

  @override
  _ToolState createState() => _ToolState();
}

class _GroupItem {
  final String title;
  final VoidCallback callback;

  _GroupItem(this.title, this.callback);
}

class _ToolState extends State<Tool> {
  final Map<String, bool> expanded = <String, bool>{};

  void _handlePromotionalInfoTap() {
    widget.controller.open(
        key: ConstViewKey.promotionalInfo,
        tab: '推广信息',
        contentIfAbsent: (_) => null);
  }

  void _manageListPage() {
    widget.controller.open(
        key: ConstViewKey.manageListPage,
        tab: '管理员列表',
        contentIfAbsent: (_) => ManageListPage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[350],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(
              groupName: '首页',
              callback: () {
                NavigatorUtils.pop(context);
              },
              icon: Container(
                width: screenUtil.adaptive(10),
              ),
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(groupName: '管理员管理', groupItems: [
              _GroupItem('管理员列表', _manageListPage),
              _GroupItem('管理员部门管理', _handlePromotionalInfoTap)
            ]),
          ),
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(groupName: '审核管理', groupItems: [
              _GroupItem('审核记录', _handlePromotionalInfoTap),
              _GroupItem('审核', _handlePromotionalInfoTap),
              _GroupItem('我的审核记录', _handlePromotionalInfoTap),
              _GroupItem('复核', _handlePromotionalInfoTap),
              _GroupItem('我的复核记录', _handlePromotionalInfoTap),
              _GroupItem('授权管理', _handlePromotionalInfoTap)
            ]),
          ),
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(
                groupName: '产品规则',
                groupItems: [_GroupItem('产品规则', _handlePromotionalInfoTap)]),
          ),
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(
                groupName: '系统管理',
                groupItems: [_GroupItem('用户日志上传', _handlePromotionalInfoTap)]),
          ),
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(
                groupName: '推广信息',
                groupItems: [_GroupItem('推广信息', _handlePromotionalInfoTap)]),
          ),
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(
                groupName: '订单信息',
                groupItems: [_GroupItem('订单信息', _handlePromotionalInfoTap)]),
          ),
          Material(
            type: MaterialType.transparency,
            child: buildToolGroup(
                groupName: '发票信息',
                groupItems: [_GroupItem('发票信息', _handlePromotionalInfoTap)]),
          ),
        ],
      ),
    );
  }

  Widget buildToolGroup(
      {String groupName,
      List<_GroupItem> groupItems,
      VoidCallback callback,
      Widget icon}) {
    assert(groupItems?.isNotEmpty == true || callback != null);
    return CustomExpansionTile(
      value: expanded[groupName] == true,
      customHead: (_, animation) => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              icon ??
                  Transform.rotate(
                    angle: math.pi * (1.5 + animation.value / 2),
                    child: const Icon(
                      Icons.expand_more,
                      size: 16,
                    ),
                  ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  groupName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (callback != null) {
            callback?.call();
          } else {
            if (expanded[groupName] == null) {
              expanded[groupName] = true;
            } else {
              expanded[groupName] = !expanded[groupName];
            }
          }
          setState(() {});
        },
      ),
      children: groupItems
              ?.map((e) => InkWell(
                    onTap: e.callback,
                    child: Container(
                      padding: const EdgeInsets.all(8.0).copyWith(left: 32),
                      alignment: Alignment.centerLeft,
                      child: Text(e.title),
                    ),
                  ))
              ?.toList(growable: false) ??
          [],
    );
  }
}
