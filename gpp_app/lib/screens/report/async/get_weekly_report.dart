import 'package:dio/dio.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<List<DailyReport>> getWeeklyReport(String uri, String date) async {
  Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  try {
    response = await dioClient.get(
      uri,
      queryParameters: {
        'date': date,
      },
      interceptor: UserAuthInterceptor(_dio),
    );
    // Handling exception
  } on DioError catch (e) {
    if (e.response != null) {
      MyLogger.error(
          'GET weekly report failed. Status code is ${e.response.statusCode}');
      throw e;
    } else {
      MyLogger.error(
          'GET weekly report failed. Error.response is null.\nrequest: ${e.request}\nmessage: ${e.message}');
      throw e;
    }
  }

  // GET Successed
  if (response != null && response.statusCode == 200) {
    MyLogger.info('GET weekly report successed');

    MyLogger.debug('weeklyReport response.data : ${response.data}');

    // Parse json to return value
    List<DailyReport> weeklyReport = [];
    for (int i = 0; i < response.data.length; i++) {
      weeklyReport.add(DailyReport.fromJson(response.data[i]));
    }
    MyLogger.debug('weeklyReport return value : ${weeklyReport.runtimeType}');
    return weeklyReport;
    // Invalid response
  } else {
    MyLogger.error('GET weekly report response is invalid');
    throw DioError(type: DioErrorType.RESPONSE);
  }
}
