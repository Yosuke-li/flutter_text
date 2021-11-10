import 'package:flutter_text/init.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'data.dart';

class MultipleCharts extends StatefulWidget {
  @override
  _MultipleChartState createState() => _MultipleChartState();
}

class _MultipleChartState extends State<MultipleCharts> {
  List<ChartsData> data = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    List<ChartsData> pro = ChartsData.listFromJson(profit['data']);
    data = pro;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RepaintBoundary(
        child: Container(
          height: screenUtil.adaptive(600),
          child: _buildMultipleAxisLineChart(),
        ),
      )),
    );
  }

  /// Returns the chart with multiple axes.
  SfCartesianChart _buildMultipleAxisLineChart() {
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          zoomMode: ZoomMode.xy,
          enablePanning: true,
          enableMouseWheelZooming: false),
      primaryXAxis:
          DateTimeAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        interval: 1000,
        labelFormat: '{value}',
      ),
      series: _getMultipleAxisLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to
  /// render on the multiple axes chart.
  List<ChartSeries<ChartsData, DateTime>> _getMultipleAxisLineSeries() {
    final List<ChartsData> chartData = data;
    return <ChartSeries<ChartsData, DateTime>>[
      ColumnSeries<ChartsData, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartsData sales, _) =>
              DateTime.parse(sales.date) as DateTime,
          yValueMapper: (ChartsData sales, _) => sales.profit,
          pointColorMapper: (ChartsData sales, _) =>
              sales.profit > 0 ? Colors.red : Colors.green,
          name: '收益'),
      SplineSeries<ChartsData, DateTime>(
          dataSource: chartData,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartsData sales, _) =>
              DateTime.parse(sales.date) as DateTime,
          yValueMapper: (ChartsData sales, _) => sales.totalProfit,
          name: '总收益')
    ];
  }
}
