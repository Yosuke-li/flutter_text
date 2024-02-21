import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_text/assembly_pack/markdown/markdown_page.dart';

/// 属性枚举
/// [1]. 枚举区代码一定要在成员和构造之上。
/// [2]. 最后一个枚举元素以 ; 结尾，其余的枚举元素以 ,结尾。
/// [3]. 枚举的构造函数 一定要是 const 构造。
enum A {
  b(label: '添加成员', icon: Icon(Icons.add)),
  c(label: '锁定', icon: Icon(Icons.lock));

  final String label;
  final Icon icon;

  const A({required this.label, required this.icon});
}

class PropertyEnum extends StatefulWidget {
  const PropertyEnum({super.key});

  @override
  State<PropertyEnum> createState() => _PropertyEnumState();
}

class _PropertyEnumState extends State<PropertyEnum> {
  late String text;

  @override
  void initState() {
    super.initState();
    text = '``` \n'
        'enum A { \n'
        "  b(label: '1'); \n\n"
        '  final String label; \n\n'
        '  const A({required this.label}); \n'
        '} \n'
        '```';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(' [1]. 枚举区代码一定要在成员和构造之上。\n'
              ' [2]. 最后一个枚举元素以 ; 结尾，其余的枚举元素以 ,结尾。\n'
              ' [3]. 枚举的构造函数 一定要是 const 构造。'),
            PopupMenuButton(
              child: Center(
                child: Text('倍速'),
              ),
              offset: Offset(10, 10),
              itemBuilder: (BuildContext context) => A.values.map((e) => PopupMenuItem(//菜单项
                value: e.label,
                child: Row(
                  children: [
                    e.icon,
                    Text(e.label),
                  ],
                ),
              ),).toList(),
            ),
            Expanded(child: Markdown(
              data: text,
            ),),
          ],
        ),
      ),
    );
  }
}
