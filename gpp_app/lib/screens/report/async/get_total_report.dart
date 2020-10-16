import 'package:dio/dio.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<List<MonthlyReport>> getTotalReport(String uri) async {
  Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  // baseUrl/pet/:petid/report/total
  try {
    response = await dioClient.get(
      uri,
      interceptor: UserAuthInterceptor(_dio),
    );
    // Handling exception
  } on DioError catch (e) {
    if (e.response != null) {
      MyLogger.error(
          'GET total report failed. Status code is ${e.response.statusCode}, data: ${e.response.data}');
      throw e;
    } else {
      MyLogger.error(
          'GET total report failed. Error.response is null.\nrequest: ${e.request}\nmessage: ${e.message}');
      throw e;
    }
  }

  // GET Successed
  if (response != null && response.statusCode == 200) {
    MyLogger.info('GET total report successed');

    MyLogger.debug('TotalReport response.data : ${response.data}');

    // Parse json to return value
    List<MonthlyReport> totalReport = [];
    for (int i = 0; i < response.data.length; i++) {
      totalReport.add(MonthlyReport.fromJson(response.data[i]));
    }
    MyLogger.debug('TotalReport return value : ${totalReport.runtimeType}');
    return totalReport;
    // Invalid response
  } else {
    MyLogger.error('GET total report response is invalid');
    throw DioError(type: DioErrorType.RESPONSE);
  }
}
