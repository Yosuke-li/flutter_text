import 'package:flutter/material.dart';

class TextHighlight extends StatelessWidget {
  final TextStyle? ordinaryStyle; //普通的样式
  final TextStyle? highlightStyle; //高亮的样式
  final String content; //文本内容
  final String? searchContent; //搜索的内容

  const TextHighlight({
    required this.content,
    super.key,
    this.searchContent,
    this.ordinaryStyle,
    this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    //搜索内容为空
    if (searchContent == null || searchContent == '') {
      return Text(
        content,
        style: ordinaryStyle,
      );
    } else {
      List<TextSpan> richList = [];
      int start = 0;
      int end;

      //遍历，进行多处高亮
      while ((end = content.indexOf(searchContent!, start)) != -1) {
        //如果搜索内容在开头位置，直接高亮，此处不执行
        if (end != 0) {
          richList.add(TextSpan(
              text: content.substring(start, end), style: ordinaryStyle));
        }
        //高亮内容
        richList.add(TextSpan(text: searchContent, style: highlightStyle));
        //赋值索引
        start = end + (searchContent!.length);
      }
      //搜索内容只有在开头或者中间位置，才执行
      if (start != content.length) {
        richList.add(TextSpan(
            text: content.substring(start, content.length),
            style: ordinaryStyle));
      }

      return RichText(
        text: TextSpan(children: richList),
      );
    }
  }
}
