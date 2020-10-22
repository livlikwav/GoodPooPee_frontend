import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:intl/intl.dart';

class TotalData {
  int length;
  String firstDate;
  String lastDate;
  int periodMonth;
  List<DateTime> dtList;
  Map<DateTime, int> ratioMap = Map();
  int meanRatio;
  int meanSuccess;
  int progressRatio;

  TotalData(List<MonthlyReport> totalReport) {
    this.length = totalReport.length;
    this.firstDate =
        DateFormat('yyyy-MM').format(DateTime.parse(totalReport[0].date));
    this.lastDate = DateFormat('yyyy-MM')
        .format(DateTime.parse(totalReport[length - 1].date));
    this.periodMonth = DateTime.parse(totalReport[length - 1].date)
            .difference(DateTime.parse(totalReport[0].date))
            .inDays ~/
        30;
    double sumRatio = 0;
    int sumSuccess = 0;
    dtList = List(length);
    // Check each monthly report
    for (int i = 0; i < length; i++) {
      DateTime dt = DateTime.parse(totalReport[i].date);
      dtList[i] = dt;
      ratioMap[dt] = (totalReport[i].ratio * 100).toInt();
      sumRatio += totalReport[i].ratio;
      sumSuccess += totalReport[i].success;
    }
    // Compute means
    this.meanRatio = (sumRatio * 100) ~/ length;
    this.meanSuccess = sumSuccess ~/ length;
    this.progressRatio = (length - 1) == 0
        // DONT COMPUTE IF THIS MONTH IS FIRST MONTH OF TRAINING
        ? 999
        : ((totalReport[length - 1].ratio - totalReport[0].ratio) * 100)
            .toInt();
    MyLogger.debug('${toString()}');
  }

  @override
  String toString() {
    return 'Parsed total report: dtList : $dtList, ratioMap : $ratioMap, firstDate : $firstDate, lastDate : $lastDate, periodMonth : $periodMonth, meanRatio : $meanRatio, meanSuccess : $meanSuccess, progressRatio : $progressRatio';
  }
}
