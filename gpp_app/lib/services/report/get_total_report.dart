import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<List<MonthlyReport>> getTotalReport(
  BuildContext context,
  String uri,
) async {
  Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  // baseUrl/pet/:petid/report/total
  try {
    response = await dioClient.get(
      uri,
      interceptor: UserAuthInterceptor(context, _dio),
    );
    // Handling exception
  } on DioError catch (e) {
    throw e; // to return error on future
  }

  // GET Successed
  MyLogger.debug('TotalReport response.data : ${response.data}');
  // Parse json to return value
  List<MonthlyReport> totalReport = [];
  for (int i = 0; i < response.data.length; i++) {
    totalReport.add(MonthlyReport.fromJson(response.data[i]));
  }
  MyLogger.debug('TotalReport return value : ${totalReport.runtimeType}');
  return totalReport;
}
