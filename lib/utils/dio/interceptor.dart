import 'package:dio/dio.dart';

class PrettyLogInterceptor extends Interceptor {
  PrettyLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printRequest(options);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err != null) {
      print('*** DioError ***:');
      print('uri: ${err.requestOptions.uri}');
      print('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }
      print('');
    }
    super.onError(err, handler);
  }

  void _printRequest(RequestOptions options) async {
    print('*** Request ***');
    _printKV('uri', options.uri);

    if (request) {
      _printKV('method', options.method);
      _printKV('responseType', options.responseType.toString());
      _printKV('followRedirects', options.followRedirects);
      _printKV('connectTimeout', options.connectTimeout);
      _printKV('receiveTimeout', options.receiveTimeout);
      _printKV('extra', options.extra);
    }
    if (requestHeader) {
      print('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v));
    }
    if (requestBody) {
      print('data:');
      _printAll(options.data);
    }
    print('');
  }

  void _printResponse(Response response) {
    _printKV('uri', response.requestOptions.uri);
    if (responseHeader) {
      _printKV('statusCode', response.statusCode.toString());
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri);
      }
      if (response.headers != null) {
        print('headers:');
        response.headers.forEach((key, v) => _printKV(' $key', v.join(',')));
      }
    }
    if (responseBody) {
      print('Response Text:');
      _printAll(response.toString());
    }
    print('');
  }

  void _printKV(String key, Object v) {
    print('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(print);
  }
}