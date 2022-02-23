import 'package:flutter/material.dart';

class LazyListPage extends StatefulWidget {
  @override
  _LazyListState createState() => _LazyListState();
}

/// 原生列表的懒加载的解决办法：
/// 使用 [Sliver] 组件
/// [CustomScrollView]、[SliverList] 和 [SliverGrid]的混合使用实现懒加载，
/// 比[ListView]实现的多数据列表流畅了许多

class _LazyListState extends State<LazyListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('懒加载'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              print('this is SliverList index = $index');
              return _buildItem(index);
            }, childCount: 1000000),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    return RepaintBoundary(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple, width: 1)),
        child: Center(child: Text('$index')),
      ),
    );
  }
}
