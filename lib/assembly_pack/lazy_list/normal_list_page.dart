import 'package:flutter/material.dart';

class NormalListPage extends StatefulWidget {
  @override
  _NormalListState createState() => _NormalListState();
}

/// 复合列表使用shrinkWrap: true卡顿严重
/// 会将列表的所有数据都预先加载完

class _NormalListState extends State<NormalListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('正常加载'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text('this is start'),
            ),
            RepaintBoundary(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  print('this is index = $index');
                  return _buildItem(index);
                },
                itemCount: 1000,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text('this is end'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 1)),
      child: Center(child: Text('$index')),
    );
  }
}
