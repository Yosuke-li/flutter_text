import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/array_helper.dart';

import 'mp_chart.dart';
import 'multiple_charts.dart';

class ListGroupPage extends StatefulWidget {
  @override
  _ListGroupState createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroupPage> {
  List<ChartsList> groups = [];

  @override
  void initState() {
    super.initState();
    setCharts();
  }

  void setCharts() {
    groups = [
      ChartsList()
        ..name = 'normal'
        ..route = MpChartsPage(),
      ChartsList()
        ..name = 'multi'
        ..route = MultipleCharts(),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('charts_list'),
      ),
      body: RepaintBoundary(
        child: ListView.builder(
          itemBuilder: (BuildContext ctx, int index) {
            return InkWell(
              onTap: () {
                NavigatorUtils.pushWidget(
                    context, ArrayHelper.get(groups, index).route);
              },
              child: Container(
                height: screenUtil.adaptive(120),
                alignment: Alignment.center,
                child: Text('${ArrayHelper.get(groups, index).name}'),
              ),
            );
          },
          itemCount: groups.length ?? 0,
        ),
      ),
    );
  }
}

class ChartsList {
  String name;
  Widget route;
}
