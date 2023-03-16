import 'package:flutter_text/init.dart';
import 'package:self_utils/utils/array_helper.dart';

import 'candle_charts.dart';
import 'mac_charts.dart';
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
      ChartsList()
        ..name = 'candle'
        ..route = CandleChartsPage(),
      ChartsList()
        ..name = 'mac_chart'
        ..route = MACChartsPage(),
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
                if (ArrayHelper.get(groups, index)?.route != null) {
                  WindowsNavigator().pushWidget(
                      context, ArrayHelper.get(groups, index)!.route!);
                }
              },
              child: Container(
                height: screenUtil.adaptive(120),
                alignment: Alignment.center,
                child: Text('${ArrayHelper.get(groups, index)?.name}'),
              ),
            );
          },
          itemCount: groups.length,
        ),
      ),
    );
  }
}

class ChartsList {
  String? name;
  Widget? route;
}
