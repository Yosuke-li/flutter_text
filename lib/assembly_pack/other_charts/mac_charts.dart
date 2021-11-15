import 'package:flutter_text/assembly_pack/other_charts/model.dart';
import 'package:flutter_text/init.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'data.dart';

class MACChartsPage extends StatefulWidget {
  @override
  _MACChartsState createState() => _MACChartsState();
}

class _MACChartsState extends State<MACChartsPage> {
  double _period;
  double _longPeriod;
  double _shortPeriod;
  TrackballBehavior _trackballBehavior;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _period = 14;
    _longPeriod = 5.0;
    _shortPeriod = 2.0;
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    setState(() {});
  }

  SfCartesianChart _buildDefaultMACCharts() {
    final List<ChartSampleData> chartData = charts;
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true),
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        dateFormat: DateFormat.MMM(),
        interval: 3,
      ),
      primaryYAxis: NumericAxis(
        minimum: 70,
        maximum: 130,
        interval: 20,
        axisLine: const AxisLine(width: 0),
      ),
      axes: [
        NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            opposedPosition: true,
            name: 'agybrd',
            interval: 2)
      ],
      indicators: [
        MacdIndicator<ChartSampleData, DateTime>(
            period: _period.toInt(),
            longPeriod: _longPeriod.toInt(),
            shortPeriod: _shortPeriod.toInt(),
            macdType: MacdType.both,
            seriesName: 'AAPL',
            yAxisName: 'agy',
            signalLineWidth: 2)
      ],
      trackballBehavior: _trackballBehavior,
      tooltipBehavior: _tooltipBehavior,
      title: ChartTitle(text: ''),
      series: <ChartSeries<ChartSampleData, DateTime>>[
        HiloOpenCloseSeries<ChartSampleData, DateTime>(
          dataSource: chartData,
          opacity: 0.7,
          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.zero),
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          lowValueMapper: (ChartSampleData sales, _) => sales.low,
          highValueMapper: (ChartSampleData sales, _) => sales.high,
          openValueMapper: (ChartSampleData sales, _) => sales.open,
          closeValueMapper: (ChartSampleData sales, _) => sales.close,
          name: 'AAPL'
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          child: _buildDefaultMACCharts(),
        ),
      ),
    );
  }
}
