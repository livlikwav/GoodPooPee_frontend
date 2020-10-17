import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<List<DailyReport>> getWeeklyReport(
  BuildContext context,
  String uri,
  String date,
) async {
  Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  try {
    response = await dioClient.get(
      uri,
      queryParameters: {
        'date': date,
      },
      interceptor: UserAuthInterceptor(context, _dio),
    );
    // Handling exception
  } on DioError catch (e) {
    throw e;
  }

  // GET Successed
  MyLogger.debug('weeklyReport response.data : ${response.data}');
  // Parse json to return value
  List<DailyReport> weeklyReport = [];
  for (int i = 0; i < response.data.length; i++) {
    weeklyReport.add(DailyReport.fromJson(response.data[i]));
  }
  MyLogger.debug('weeklyReport return value : ${weeklyReport.runtimeType}');
  return weeklyReport;
}
