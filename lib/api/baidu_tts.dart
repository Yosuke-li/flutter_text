import 'package:dio/dio.dart';
import 'package:flutter_text/model/baidu_tts.dart';

class BaiduTtsApi {
  final String TokenUrl = 'https://openapi.baidu.com/oauth/2.0/token';
  final String TtsUrl = 'https://tsn.baidu.com/text2audio?tex=';       //仅支持中英文
  final String TTs_text = '&lan=zh&cuid=mytextapp&per=0&ctp=1&tok=';
  final apiKey = 'evzV0Wh5trnqcuQGFP0lTONq';
  final appSecret = 'fNw9TvO7ZoiRm9Lyy1aszAyYjVIRHV68';
  BaseOptions baseOptions;
  Token _token;

  Future<Token> getBaiduToken() async {
    try {
      final Response response = await Dio(baseOptions)
          .post(TokenUrl, options: Options(), queryParameters: {
        'grant_type': 'client_credentials',
        'client_id': apiKey,
        'client_secret': appSecret,
      });
      _token = Token.formJson(response.data);
      return _token;
    } catch (e) {
      print('error ============> $e');
      rethrow;
    }
  }
}
