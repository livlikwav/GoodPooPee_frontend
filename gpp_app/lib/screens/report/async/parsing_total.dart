import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/util/my_logger.dart';

class TotalData {
  int length;
  Map<String, int> ratioMap = Map();
  int meanRatio;
  int meanSuccess;
  int progressRatio;

  TotalData(List<MonthlyReport> totalReport) {
    this.length = totalReport.length;
    int sumCount = 0;
    int sumSuccess = 0;
    // Check each monthly report
    for (int i = 0; i < length; i++) {
      ratioMap[totalReport[i].date] = (totalReport[i].ratio * 100).toInt();
      sumCount += totalReport[i].count;
      sumSuccess += totalReport[i].success;
    }
    // Compute means
    this.meanRatio = (sumSuccess * 100) ~/ sumCount;
    this.meanSuccess = sumSuccess ~/ length;
    this.progressRatio = (length - 1) == 0
        ? -1
        : ((totalReport[length - 1].ratio - totalReport[0].ratio) * 100)
            .toInt();
    MyLogger.debug('TOTAL: meanRatio : $meanRatio');
    MyLogger.debug('TOTAL: meanSuccess : $meanSuccess');
    MyLogger.debug('TOTAL: progressRatio : $progressRatio');
    MyLogger.debug('TOTAL: ratioMap : $ratioMap');
  }
}
