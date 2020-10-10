import 'package:dio/dio.dart';
// import 'package:gpp_app/util/my_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthInterceptor extends Interceptor {
  UserAuthInterceptor(Dio dio);

  Dio dio;
  String userAuth;

  @override
  Future onRequest(RequestOptions options) async {
    // dio.lock();
    final prefs = await SharedPreferences.getInstance();
    userAuth = prefs.getString('userAuth');
    if (userAuth != null) {
      options.headers['Authorization'] = 'Bearer ' + userAuth;
      // MyLogger.debug('Authorization header: ${"Bearer " + userAuth}');
      // dio.unlock();
      return options;
    } else {
      dio.reject('Empty userAuth, maybe check login process');
      return options;
    }
  }

  @override
  Future onResponse(Response response) async {}

  @override
  Future onError(DioError e) async {}
}
