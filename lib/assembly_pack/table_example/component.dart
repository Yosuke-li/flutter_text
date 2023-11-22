import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/management/utils/navigator.dart';
import 'package:flutter_text/assembly_pack/table_example/page_one.dart';
import 'package:flutter_text/assembly_pack/table_example/page_two.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/model/AComponent.dart';
import 'package:self_utils/utils/array_helper.dart';

class TableListComponentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TableListComponentPageState();
}

class TableListComponentPageState extends State<TableListComponentPage> {
  List<PageModel> _page = [];

  @override
  void initState() {
    super.initState();
    _page = [
      PageModel()
        ..name = 'Table one normal'
        ..pageUrl = const PageOne(),
      PageModel()
        ..name = 'Table two Group'
        ..pageUrl = const PageTwo(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalStore.isMobile
          ? AppBar(
        title: const Text('table_list'),
      )
          : null,
      body: Center(
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
    );
  }
}
