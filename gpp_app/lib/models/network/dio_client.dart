import 'package:dio/dio.dart';
import 'dart:developer' as developer;

import 'package:gpp_app/util/my_logger.dart';

class DioClient {
  // for url
  static String server_url = 'https://dev.goodpoopee.com/';
  // static String server_url = 'http://localhost/';

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
  }) async {
    MyLogger.info('DioClient.get.uri: $uri');
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      throw e;
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
  }) async {
    try {
      MyLogger.info('DioClient.post.uri: $uri');
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
}
