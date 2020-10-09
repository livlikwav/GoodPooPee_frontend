import 'package:dio/dio.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<MonthlyReport> getMonthlyReport(String uri, String date) async {
  Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  // server/pet/report/monthly GET
  // path: pet_id
  // query: day_date
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
          'GET monthly report failed. Status code is ${e.response.statusCode}');
      return null;
    } else {
      MyLogger.error(
          'GET monthly report failed. Error.response is null.\n${e.request}\n${e.message}');
      return null;
    }
  }
  // GET Successed
  if (response != null && response.statusCode == 200) {
    MyLogger.info('GET monthly report successed');

    MyLogger.debug('${response.data}');

    // Parse json to return value
    return MonthlyReport.fromJson(response.data);
  } else {
    // response == null (server response is invalid)
    return null;
  }
}
