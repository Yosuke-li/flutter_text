import 'package:flutter_text/init.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'data.dart';
import 'model.dart';

class CandleChartsPage extends StatefulWidget {

  @override
  _CandleChartsState createState()=> _CandleChartsState();
}

class _CandleChartsState extends State<CandleChartsPage> {

  bool _enableSolidCandle;
  bool _toggleVisibility;
  TrackballBehavior _trackballBehavior;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 450,
          child: _buildCandle(),
        ),
      ),
    );
  }

  ///Get the cartesian chart with candle series
  SfCartesianChart _buildCandle() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'AAPL - 2016'),
      primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMM(),
          interval: 3,
          intervalType: DateTimeIntervalType.months,
          minimum: DateTime(2016, 01, 01),
          maximum: DateTime(2016, 10, 01),
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          minimum: 140,
          maximum: 60,
          interval: 20,
          labelFormat: r'${value}',
          axisLine: const AxisLine(width: 0)),
      series: _getCandleSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  /// It returns the candle series to the chart.
  List<CandleSeries<ChartSampleData, DateTime>> _getCandleSeries() {
    final List<ChartSampleData> chartData = charts;
    return <CandleSeries<ChartSampleData, DateTime>>[
      CandleSeries<ChartSampleData, DateTime>(
          enableSolidCandles: _enableSolidCandle,
          dataSource: chartData,
          name: 'AAPL',
          showIndicationForSameValues: _toggleVisibility,
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,

          /// High, low, open and close values used to render the candle series.
          lowValueMapper: (ChartSampleData sales, _) => sales.low,
          highValueMapper: (ChartSampleData sales, _) => sales.high,
          openValueMapper: (ChartSampleData sales, _) => sales.open,
          closeValueMapper: (ChartSampleData sales, _) => sales.close,
      )
    ];
  }

  @override
  void initState() {
    _enableSolidCandle = false;
    _toggleVisibility = true;
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }
}