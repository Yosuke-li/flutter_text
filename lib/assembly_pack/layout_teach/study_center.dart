import 'package:flutter_text/assembly_pack/layout_teach/basic/inheritwidget_test.dart';
import 'package:flutter_text/assembly_pack/layout_teach/material/material_main.dart';
import 'package:flutter_text/model/AComponent.dart';

import '../../init.dart';
import 'basic/basic_type.dart';

class StudyCenterPage extends StatefulWidget {
  const StudyCenterPage({super.key});

  @override
  State<StudyCenterPage> createState() => _StudyCenterPageState();
}

class _StudyCenterPageState extends State<StudyCenterPage> {
  List<PageModel> _page = [];

  @override
  void initState() {
    super.initState();
    _page = [
      PageModel()
        ..name = 'BasicTypePage'
        ..pageUrl = const BasicTypePage(),
      PageModel()
        ..name = 'Material3学习'
        ..pageUrl = const MaterialThreeMain(),
      PageModel()
        ..name = 'inheritedWidget'
        ..pageUrl = const InheritedWidgetTest(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalStore.isMobile
          ? AppBar(
              title: const Text('学习中心'),
            )
          : null,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: const Text(
                '!!!此处的学习组件点击之后都可以查看一些关于组件的tip!!!',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Expanded(
              child: GridView.custom(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      WindowsNavigator().pushWidget(
                        context,
                        ArrayHelper.get(_page, index)?.pageUrl,
                        title: ArrayHelper.get(_page, index)?.name,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('${ArrayHelper.get(_page, index)?.name}'),
                    ),
                  );
                }, childCount: _page.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
