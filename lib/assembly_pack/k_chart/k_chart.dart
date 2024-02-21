import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/entity/index.dart';
import 'package:k_chart/flutter_k_chart.dart';

class KChartPage extends StatefulWidget {
  @override
  KChartState createState() => KChartState();
}

class KChartState extends State<KChartPage> {
  List<KLineEntity> data = [];
  bool showLoading = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  MainState _mainState = MainState.MA;
  bool isLine = false;
  bool isChinese = true;
  bool _volHidden = true;
  bool _hideGrid = false;
  bool _showNowPrice = true;
  List<DepthEntity> _bids = [];
  List<DepthEntity> _asks = [];
  bool isChangeUI = false;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  @override
  void initState() {
    super.initState();
    getData('1day');
    rootBundle.loadString('assets/depth.json').then((value) {
      final parseJson = json.decode(value);
      final tick = parseJson['tick'] as Map<String, dynamic>;
      final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
          .map<DepthEntity>(
              (item) => DepthEntity(item[0] as double, item[1] as double))
          .toList();
      final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
          .map<DepthEntity>(
              (item) => DepthEntity(item[0] as double, item[1] as double))
          .toList();
      initDepth(bids, asks);
    });
  }

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((DepthEntity left, DepthEntity right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids.insert(0, item);
    });

    amount = 0.0;
    asks.sort((DepthEntity left, DepthEntity right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks.add(item);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: 450,
              width: double.infinity,
              child: KChartWidget(
                data,
                chartStyle,
                chartColors,
                isLine: isLine,
                mainState: _mainState,
                volHidden: _volHidden,
                secondaryState: _secondaryState,
                fixedLength: 2,
                timeFormat: TimeFormat.YEAR_MONTH_DAY,
                translations: kChartTranslations,
                showNowPrice: _showNowPrice,
                hideGrid: _hideGrid,
                isTapShowInfoDialog: true,
                isTrendLine: true,
                maDayList: const [1, 100, 1000],
              ),
            ),
            if (showLoading)
              Container(
                  width: double.infinity,
                  height: 450,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()),
          ]),
          buildButtons(),
          if (_bids != null && _asks != null)
            Container(
              height: 230,
              width: double.infinity,
              child: DepthChart(_bids, _asks, chartColors),
            )
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        button('Time Mode', onPressed: () => isLine = true),
        button('K Line Mode', onPressed: () => isLine = false),
        button('Line:MA', onPressed: () => _mainState = MainState.MA),
        button('Line:BOLL', onPressed: () => _mainState = MainState.BOLL),
        button('Hide Line', onPressed: () => _mainState = MainState.NONE),
        button('Secondary Chart:MACD', onPressed: () => _secondaryState = SecondaryState.MACD),
        button('Secondary Chart:KDJ', onPressed: () => _secondaryState = SecondaryState.KDJ),
        button('Secondary Chart:RSI', onPressed: () => _secondaryState = SecondaryState.RSI),
        button('Secondary Chart:WR', onPressed: () => _secondaryState = SecondaryState.WR),
        button('Secondary Chart:CCI', onPressed: () => _secondaryState = SecondaryState.CCI),
        button('Secondary Chart:Hide', onPressed: () => _secondaryState = SecondaryState.NONE),
        button(_volHidden ? 'Show Vol' : 'Hide Vol',
            onPressed: () => _volHidden = !_volHidden),
        button('Change Language', onPressed: () => isChinese = !isChinese),
        button(_hideGrid ? 'Show Grid' : "Hide Grid",
            onPressed: () => _hideGrid = !_hideGrid),
        button(_showNowPrice ? "Hide Now Price" : 'Show Now Price',
            onPressed: () => _showNowPrice = !_showNowPrice),
        button('Customize UI', onPressed: () {
          setState(() {
            isChangeUI = !isChangeUI;
            if(isChangeUI) {
              chartColors.selectBorderColor = Colors.red;
              chartColors.selectFillColor = Colors.red;
              chartColors.lineFillColor = Colors.red;
              chartColors.kLineColor = Colors.yellow;
            } else {
              chartColors.selectBorderColor = Color(0xff6C7A86);
              chartColors.selectFillColor = Color(0xff0D1722);
              chartColors.lineFillColor = Color(0x554C86CD);
              chartColors.kLineColor = Color(0xff4C86CD);
            }
          });
        }),
      ],
    );
  }

  Widget button(String text, {VoidCallback? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          setState(() {});
        }
      },
      child: Text(text),
      style: TextButton.styleFrom(
        minimumSize: const Size(88, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void getData(String period) {
    rootBundle.loadString('assets/result.json').then((String value) {
      final Map parseJson = json.decode(value) as Map<dynamic, dynamic>;
      final list = parseJson['data'] as List<dynamic>;
      data = list
          .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      DataUtil.calculate(data);
      showLoading = false;
      setState(() {});
    });
  }

  // void getData(String period) {
  //   final Future<String> future = getIPAddress(period);
  //   future.then((String result) {
  //     final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
  //     final list = parseJson['data'] as List<dynamic>;
  //     data = list
  //         .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
  //         .toList()
  //         .reversed
  //         .toList()
  //         .cast<KLineEntity>();
  //     DataUtil.calculate(data);
  //     showLoading = false;
  //     setState(() {});
  //   }).catchError((_) {
  //     showLoading = false;
  //     setState(() {});
  //     print('### datas error $_');
  //   });
  // }
  //
  // //获取火币数据，需要翻墙
  // Future<String> getIPAddress(String period) async {
  //   var url =
  //       'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';
  //   String result;
  //   final response = await loadingCallback(
  //     () => Request.get(url),
  //   );
  //   if (response.statusCode == 200) {
  //     result = response.data;
  //   } else {
  //     print('Failed getting IP address');
  //   }
  //   Log.info(result);
  //   return result;
  // }
}
