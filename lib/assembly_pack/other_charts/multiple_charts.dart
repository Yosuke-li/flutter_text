import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:intl/intl.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              child: Container(
                height: screenUtil.adaptive(700),
                child: _buildMultipleAxisLineChart(),
              ),
            ),
            RepaintBoundary(
              child: Container(
                height: screenUtil.adaptive(700),
                child: _buildMultipleAxisSpLineChart(),
              ),
            )
          ],
        ),
      ),
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
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        dateFormat: DateFormat('MM/dd'),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        interval: 1000,
        labelFormat: '{value}',
        numberFormat: NumberFormat.compact(),
      ),
      legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          alignment: ChartAlignment.near,
          overflowMode: LegendItemOverflowMode.wrap),
      series: _getMultipleAxisLineSeries(),
      trackballBehavior: TrackballBehavior(
          enable: true,
          shouldAlwaysShow: true,
          activationMode: ActivationMode.singleTap,
          builder: (BuildContext context, TrackballDetails trackballDetails) {
            return trackballDetails.groupingModeInfo.points.isNotEmpty
                ? Container(
              height: 75,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(66, 244, 164, 0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '时间：${DateTimeHelper.datetimeFormat(trackballDetails.groupingModeInfo.points[0].xValue ~/ 1000, 'yyyy-MM-dd')}'),
                  for (int i = 0;
                  i < trackballDetails.groupingModeInfo.points.length;
                  i++)
                    Text(
                        '${trackballDetails.groupingModeInfo.points[i].dataLabelMapper}：${trackballDetails.groupingModeInfo.points[i].y}'),
                ],
              ),
            )
                : Container();
          },
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          tooltipSettings: const InteractiveTooltip(
              format: 'point.x : point.y', borderWidth: 0)),
    );
  }

  List<ChartSeries<ChartsData, DateTime>> _getMultipleAxisLineSeries() {
    final List<ChartsData> chartData = data;
    return <ChartSeries<ChartsData, DateTime>>[
      ColumnSeries<ChartsData, DateTime>(
        dataSource: chartData,
        xValueMapper: (ChartsData sales, _) => DateTime.parse(sales.date),
        yValueMapper: (ChartsData sales, _) => sales.profit,
        dataLabelMapper: (ChartsData sales, _) => '收益',
        pointColorMapper: (ChartsData sales, _) =>
            sales.profit > 0 ? Colors.red : Colors.green,
        name: '收益',
      ),
      LineSeries<ChartsData, DateTime>(
        dataSource: chartData,
        yAxisName: 'yAxis1',
        xValueMapper: (ChartsData sales, _) => DateTime.parse(sales.date),
        yValueMapper: (ChartsData sales, _) => sales.totalProfit,
        dataLabelMapper: (ChartsData sales, _) => '总收益',
        name: '总收益',
      )
    ];
  }

  SfCartesianChart _buildMultipleAxisSpLineChart() {
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          zoomMode: ZoomMode.xy,
          enablePanning: true,
          enableMouseWheelZooming: false),
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        dateFormat: DateFormat('MM/dd'),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        opposedPosition: false,
        interval: 1000,
        labelFormat: '{value}',
        numberFormat: NumberFormat.compact(),
      ),
      legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          alignment: ChartAlignment.near,
          overflowMode: LegendItemOverflowMode.wrap),
      series: _getMultipleAxisSpLineSeries(),
      trackballBehavior: TrackballBehavior(
          enable: true,
          shouldAlwaysShow: true,
          activationMode: ActivationMode.singleTap,
          builder: (BuildContext context, TrackballDetails trackballDetails) {
            return trackballDetails.groupingModeInfo.points.isNotEmpty
                ? Container(
                    height: 75,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(66, 244, 164, 0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '时间：${DateTimeHelper.datetimeFormat(trackballDetails.groupingModeInfo.points[0].xValue ~/ 1000, 'yyyy-MM-dd')}'),
                        for (int i = 0;
                            i < trackballDetails.groupingModeInfo.points.length;
                            i++)
                          Text(
                              '${trackballDetails.groupingModeInfo.points[i].dataLabelMapper}：${trackballDetails.groupingModeInfo.points[i].y}'),
                      ],
                    ),
                  )
                : Container();
          },
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          tooltipSettings: const InteractiveTooltip(
              format: 'point.x : point.y', borderWidth: 0)),
    );
  }

  List<ChartSeries<ChartsData, DateTime>> _getMultipleAxisSpLineSeries() {
    final List<ChartsData> chartData = data;
    return <ChartSeries<ChartsData, DateTime>>[
      SplineSeries<ChartsData, DateTime>(
        dataSource: chartData,
        yAxisName: 'yAxis1',
        xValueMapper: (ChartsData sales, _) => DateTime.parse(sales.date),
        yValueMapper: (ChartsData sales, _) => sales.totalProfit,
        dataLabelMapper: (ChartsData sales, _) => '总收益',
        name: '总收益',
      ),
      ColumnSeries<ChartsData, DateTime>(
        dataSource: chartData,
        xValueMapper: (ChartsData sales, _) => DateTime.parse(sales.date),
        yValueMapper: (ChartsData sales, _) => sales.profit,
        dataLabelMapper: (ChartsData sales, _) => '收益',
        pointColorMapper: (ChartsData sales, _) =>
        sales.profit > 0 ? Colors.red : Colors.green,
        name: '收益',
      ),
    ];
  }
}
