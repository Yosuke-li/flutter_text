import 'package:dio/dio.dart';
import 'package:flutter_text/model/weather.dart';

class WeatherApi {
  final String rootUrl = "https://free-api.heweather.net/s6/weather";
//  final String key = "4bd90d9b0ddc48d98ad38f8eb5d810f4"; //2466953681@qq.com的key  访问量为1000/1000
  final String key = "43cc143519724d739fb0e717ddf6ab25";    //690575679@qq.com的key
  final BaseOptions baseOptions = BaseOptions(connectTimeout: 10000);

  //获取实时天气
  Future getRealTimeWeather(String cid) async {
    String url = rootUrl + '/now';
    RealTimeWeather _realTimeWeather;
    try {
      Response response =
          await Dio(baseOptions).get(url, options: Options(), queryParameters: {
        'location': cid,
        'key': key,
      });
      _realTimeWeather =
          RealTimeWeather.fromJson(response.data['HeWeather6'].first);
      _realTimeWeather.basic = Basic.fromJson(_realTimeWeather.mBasic);
      _realTimeWeather.update = Update.fromJson(_realTimeWeather.mUpdate);
      _realTimeWeather.now = Now.fromJson(_realTimeWeather.mNow);

      return _realTimeWeather;
    } catch (e) {
      print('getRealTimeWeather error = ${e}');
      return null;
    }
  }

  //获取三天预测天气
  Future getThreeDayWeather(String cid) async {
    String url = rootUrl + '/forecast';
    ThreeDaysForecast _threeDaysForecast;
    try {
      Response response =
          await Dio(baseOptions).get(url, options: Options(), queryParameters: {
        'location': cid,
        'key': key,
      });
      _threeDaysForecast =
          ThreeDaysForecast.fromJson(response.data['HeWeather6'].first);

      _threeDaysForecast.basic = Basic.fromJson(_threeDaysForecast.mBasic);
      _threeDaysForecast.update = Update.fromJson(_threeDaysForecast.mUpdate);
      for (var d in _threeDaysForecast.mDailyForecasts) {
        _threeDaysForecast.dailyForecasts.add(DailyForecast.fromJson(d));
      }
      return _threeDaysForecast;
    } catch (e) {
      print('getThreeDayWeather error = ${e}');
      return null;
    }
  }

  Future searchCity(String keyword) async {
    String url = "https://search.heweather.net/find";
    try {
      Response response = await Dio(baseOptions).get(url,
          options: Options(),
          queryParameters: {'location': keyword, 'key': key, 'group': 'cn'});

      List<Basic> cityList = [];
      if (response.data['HeWeather6'] != null) {
        for (var c in response.data['HeWeather6'].first['basic']) {
          cityList.add(Basic.fromJson(c));
        }
      }
      print(response.data);
      return cityList;
    } catch (e) {
      return null;
    }
  }
}
