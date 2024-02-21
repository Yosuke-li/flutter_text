import 'package:flutter/material.dart';

class BasicSwitchWidget extends StatefulWidget {
  const BasicSwitchWidget({super.key});

  @override
  State<BasicSwitchWidget> createState() => _BasicSwitchWidgetState();
}

class _BasicSwitchWidgetState extends State<BasicSwitchWidget> {
  bool _switch = true;
  bool? _checkBox = true;

  /// setState里做了什么
  /// 1.首先通过mounted判断setState是否合规
  /// 2.然后操作element.markNeedBuilds将元素标记为脏(dirty)，并通过scheduleBuilder添加到链表里等待之后的更新
  /// 3.系统调用widget.scheduleFrame更新帧，之后重构页面。

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Switch(
            value: _switch,
            onChanged: (value) {
              setState(() {
                _switch = value;
              });
            },
          ),
          Checkbox(value: _checkBox, onChanged: (value) {
            setState(() {
              _checkBox = value;
            });
          }),
        ],
      ),
    );
  }
}
