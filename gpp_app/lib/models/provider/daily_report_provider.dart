import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/services/report/get_daily_report.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:intl/intl.dart';

class DailyReportProvider extends ChangeNotifier {
  DailyReportProvider(int petId) {
    this.petId = petId;
    petId == null ? isPetNull = true : isPetNull = false;
    MyLogger.debug('DailyReportProvider initialized: petID $petId');
  }
  int petId;
  bool isPetNull;
  final String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future<DailyReport> dailyReport;

  void initRecords(BuildContext context) {
    if (!isPetNull) {
      dailyReport = getDailyReport(
        context,
        DioClient.serverUrl + 'pet/' + petId.toString() + '/report/daily',
        todaysDate,
      );
    } else {
      MyLogger.debug('DailyReportProvider initRecords: pet is null');
    }
  }

  // void updateRecords(BuildContext context, DateTime picked) {
  //   datetime = picked;
  //   petRecords = getPetRecords(
  //     context,
  //     DioClient.serverUrl + 'pet/' + petId.toString() + '/records',
  //   );
  //   notifyListeners();
  // }
}
