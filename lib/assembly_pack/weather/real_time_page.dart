import 'dart:async';

import 'package:flutter_text/assembly_pack/weather/search_city.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_text/api/weather.dart';
import 'package:flutter_text/model/weather.dart';

void main() => runApp(RealTimePage());

class RealTimePage extends StatefulWidget {
  RealTimeWeatherState createState() => RealTimeWeatherState();
}

class RealTimeWeatherState extends State<RealTimePage> {
  String cid = '深圳'; //地区 --可拓展选择查看其他地区的天气
  Timer _timer; //真·实时天气
  RealTimeWeather _realTimeWeather;
  ThreeDaysForecast _threeDaysForecast;
  bool isLoading = true;

  //获取实时天气
  void getRealTimeWeather(String cid) async {
    final result = await WeatherApi().getRealTimeWeather(cid);
    if (result != null) {
      if (result.status == 'ok') {
        setState(() {
          isLoading = false;
          _realTimeWeather = result;
        });
      }
    }
  }

  //获取三天预测天气
  void getThreeDayWeather(String cid) async {
    final threeResult = await WeatherApi().getThreeDayWeather(cid);
    if (threeResult != null) {
      if (threeResult.status == 'ok') {
        setState(() {
          _threeDaysForecast = threeResult;
        });
      }
    }
  }

  //生命周期
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      //轮询
      getRealTimeWeather(cid);
    });
    getThreeDayWeather(cid);
  }

  //清除轮询
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1000, height: 2111)..init(context);
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Colors.blue, Colors.blue.withOpacity(0.4)],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '${_realTimeWeather.basic.location}',
                              style: TextStyle(
                                fontSize: screenUtil.setSp(80),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0, bottom: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${_realTimeWeather.now.fl} ℃',
                                    style: TextStyle(
                                        fontSize: screenUtil.setSp(100),
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/weather/${_realTimeWeather.now.condCode}.png',
                                        width: 40,
                                        height: 40,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        '${_realTimeWeather.now.condTxt}',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 50.0, bottom: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'images/weather/507.png',
                                      width: 30.0,
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('风向',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text('${_realTimeWeather.now.windDir}',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'images/weather/399.png',
                                      width: 30.0,
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('湿度',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text('${_realTimeWeather.now.hum}%',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'images/weather/900.png',
                                      width: 30.0,
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('气压',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text('${_realTimeWeather.now.pres}hpa',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: _threeDaysForecast.dailyForecasts
                                    .map((item) {
                                  return _threeDayWeather(item);
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 40,
                      right: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.location_city),
                                      title: Text('切换城市'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchCity()))
                                            .then((value) {
                                          setState(() {
                                            isLoading = true;
                                            cid = value;
                                          });
                                        });
                                      },
                                    ),
                                    Divider(height: 0.0),
                                  ],
                                );
                              });
                        },
                      ))
                ],
              ));
  }

  //3天天气预测
  Widget _threeDayWeather(DailyForecast dailyForecast) {
    String date = DateFormat('EE').format(DateTime.parse(dailyForecast.date));
    return Column(
      children: <Widget>[
        Text(date, style: TextStyle(color: Color(0xff8a8a8a))),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset('images/weather/${dailyForecast.condCodeD}.png',
              width: 50, height: 50, color: Colors.blue),
        ),
        Text(dailyForecast.condTxtD,
            style: TextStyle(color: Color(0xff8a8a8a))),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(dailyForecast.tmpMin + '℃~' + dailyForecast.tmpMax + '℃',
              style: TextStyle(color: Color(0xff8a8a8a))),
        ),
      ],
    );
  }
}
