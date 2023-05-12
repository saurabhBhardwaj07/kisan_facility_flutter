import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/cache/storage_shared_pref.dart';

final networkClientProvider = Provider((ref) => NetworkClient());

class NetworkClient {
  late Dio _client;

  NetworkClient() {
    _client = Dio();
    _client.interceptors.add(_interceptor());
    _client.interceptors.add(_logInterceptor());
    _client.interceptors.add(dioLoggerInterceptor);
    _client.options = _options();
  }

  Interceptor _interceptor() {
    return InterceptorsWrapper(onRequest:
        (RequestOptions request, RequestInterceptorHandler handler) async {
      var storageToken = await StorageHelper.getStringIn(StorageKeys.token);
      if (storageToken != "") {
        request.headers.addAll({
          "Authorization": 'Bearer $storageToken',
        });
      }

      return handler.next(request);
    }, onError: (DioError e, handler) {
      print('${e.message} message');
      print('${e.response} response');
      return handler.next(e);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    });
  }

  LogInterceptor _logInterceptor() {
    return LogInterceptor(
        requestBody: true, responseBody: true, requestHeader: false);
  }

  BaseOptions _options() {
    return BaseOptions(
        responseType: ResponseType.json, baseUrl: _client.options.baseUrl);
  }

  Future<Response> post(String url, {dynamic body}) =>
      _client.post(url, data: body);

  Future<Response> get(String url, {dynamic query}) =>
      _client.get(url, queryParameters: query);
}
