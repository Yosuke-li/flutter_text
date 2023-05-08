import 'package:flutter_text/init.dart';
import 'package:flutter_text/model/AComponent.dart';

import 'example_one.dart';
import 'example_thr.dart';
import 'example_two.dart';

class PaintMain extends StatefulWidget {
  const PaintMain({Key? key}) : super(key: key);

  @override
  State<PaintMain> createState() => _PaintMainState();
}

class _PaintMainState extends State<PaintMain> {
  List<PageModel> _page = [];

  @override
  void initState() {
    super.initState();
    _page = [
      PageModel()
        ..name = 'repaint的用法--PaintExampleOne'
        ..pageUrl = const PaintExampleOne(),
      PageModel()
        ..name = 'PaintExampleTwo'
        ..pageUrl = const PaintExampleTwo(),
      PageModel()
        ..name = '振幅研究 -- PaintExampleThr'
        ..pageUrl = const PaintExampleThr(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
