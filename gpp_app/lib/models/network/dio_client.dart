import 'package:dio/dio.dart';

import 'package:gpp_app/util/my_logger.dart';

class DioClient {
  // for url
  static String serverUrl = 'https://dev.goodpoopee.com/';
  // static String serverUrl = 'http://localhost/';

  // dio instance
  final Dio _dio;

  // injecting dio instance
  // :Ex: final DioClient dioClient = DioClient(Dio());
  DioClient(this._dio);

  // Get
  // :Return: Future<dynamic>, so in use then() to print return value
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    Interceptor interceptor,
  }) async {
    MyLogger.info('DioClient.get.uri: $uri');
    // add interceptor
    if (interceptor != null) {
      _dio.interceptors.add(interceptor);
    }
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      // GET Successed
      if (response != null) {
        MyLogger.info('GET $uri succeed. Status code: ${response.statusCode}');
        return response;
      } else {
        MyLogger.error('GET $uri response is invalid');
        throw DioError(type: DioErrorType.RESPONSE);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        MyLogger.error(
            'GET $uri failed\nStatus code is ${e.response.statusCode}\ndata: ${e.response.data}');
        throw e;
      } else {
        MyLogger.error(
            'GET $uri failed. Error.response is null.\nrequest: ${e.request}\nmessage: ${e.message}');
        throw e;
      }
    }
  }

  // Post
  // :Return: Future<dynamic>, so in use then() to print return value
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    Interceptor interceptor,
  }) async {
    MyLogger.info('DioClient.post.uri: $uri');
    // add interceptor
    if (interceptor != null) {
      _dio.interceptors.add(interceptor);
    }
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      // POST Successed
      if (response != null) {
        MyLogger.info(
            'POST $uri successed. Status code: ${response.statusCode}');
        return response;
      } else {
        MyLogger.error('POST $uri response is invalid');
        throw DioError(type: DioErrorType.RESPONSE);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        MyLogger.error(
            'POST $uri failed.\nStatus code is ${e.response.statusCode}\ndata: ${e.response.data}');
        throw e;
      } else {
        MyLogger.error(
            'POST $uri failed. Error.response is null.\n${e.request}\n${e.message}');
        throw e;
      }
    }
  }

  // Put
  // :Return: Future<dynamic>, so in use then() to print return value
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    Interceptor interceptor,
  }) async {
    MyLogger.info('DioClient.put.uri: $uri');
    // add interceptor
    if (interceptor != null) {
      _dio.interceptors.add(interceptor);
    }
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      // PUT Successed
      if (response != null) {
        MyLogger.info('PUT $uri succeed. Status code: ${response.statusCode}');
        return response;
      } else {
        MyLogger.error('PUT $uri response is invalid');
        throw DioError(type: DioErrorType.RESPONSE);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        MyLogger.error(
            'PUT $uri failed.\nStatus code is ${e.response.statusCode}\ndata: ${e.response.data}');
        throw e;
      } else {
        MyLogger.error(
            'PUT $uri failed. Error.response is null.\n${e.request}\n${e.message}');
        throw e;
      }
    }
  }
}
