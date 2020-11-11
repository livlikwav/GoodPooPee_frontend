import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:provider/provider.dart';
// import 'package:gpp_app/util/my_logger.dart';

class UserAuthInterceptor extends Interceptor {
  UserAuthInterceptor(this._context, this._dio);

  final BuildContext _context;
  final Dio _dio;

  @override
  Future onRequest(RequestOptions options) async {
    // dio.lock();
    String accessToken =
        Provider.of<UserProfile>(_context, listen: false).accessToken;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer ' + accessToken;
      MyLogger.debug('Authorization header: ${"Bearer " + accessToken}');
      // dio.unlock();
      return options;
    } else {
      _dio.reject('Empty userAuth, maybe check login process');
      return options;
    }
  }

  @override
  Future onResponse(Response response) async {}

  @override
  Future onError(DioError e) async {}
}
