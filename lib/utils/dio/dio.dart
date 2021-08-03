import 'package:dio/dio.dart';

class DioHttpClient {
  static const int _DEFAULT_CONNECT_TIMEOUT = 60 * 1000;
  static const int _DEFAULT_SEND_TIMEOUT = 60 * 1000;
  static const int _DEFAULT_RECEIVE_TIMEOUT = 60 * 1000;

  final Map<String, Dio> _mClientMap = <String, Dio>{};

  DioHttpClient._internal();

  static final DioHttpClient _instance = DioHttpClient._internal();

  factory DioHttpClient.getInstance() => _instance;

  Dio getClient(String baseUrl,
      {BaseOptions newOptions, List<Interceptor> interceptors}) {
    final Dio client =
        _mClientMap[baseUrl] ?? _createDioClient(baseUrl, options: newOptions);
    if (interceptors != null) {
      client.interceptors.addAll(interceptors);
    }
    return client;

  }

  Dio _createDioClient(String baseUrl, {BaseOptions options}) {
    options ??= createOptions(baseUrl);
    return Dio(options);
  }

  static BaseOptions createOptions(String baseUrl,
      {Map<String, dynamic> headers, Map<String, dynamic> queryParameters}) {
    return BaseOptions(
      connectTimeout: _DEFAULT_CONNECT_TIMEOUT,
      sendTimeout: _DEFAULT_SEND_TIMEOUT,
      receiveTimeout: _DEFAULT_RECEIVE_TIMEOUT,
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      validateStatus: (status) {
        return true;
      },
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  void release() {
    _mClientMap.clear();
  }
}