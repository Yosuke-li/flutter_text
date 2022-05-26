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

  const Tool({Key? key, required this.controller}) : super(key: key);

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
        contentIfAbsent: (_) => Container());
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

        ],
      ),
    );
  }


  Widget buildToolGroup(
      {required ViewKey key,
        required String groupName,
        List<_GroupItem>? groupItems,
        VoidCallback? callback,
        VoidCallback? longPressCallBack,
        Widget? icon}) {
    return CustomExpansionTile(
      value: expanded[groupName] == true,
      customHead: (_, animation) => InkWell(
        child: SizedBox(
          width: 60,
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      if (groupName.isNotEmpty)
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
              ),
              Container(
                width: 4,
                color: widget.controller.current?.key == key
                    ? const Color(0xff50A250)
                    : const Color(0xff333333),
              ),
            ],
          ),
        ),
        onLongPress: () {
          longPressCallBack?.call();
        },
        onTap: () {
          if (callback != null) {
            callback.call();
          } else {
            if (expanded[groupName] == null) {
              expanded[groupName] = true;
            } else {
              expanded[groupName] = !expanded[groupName]!;
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
          .toList(growable: false) ??
          [],
    );
  }
}
