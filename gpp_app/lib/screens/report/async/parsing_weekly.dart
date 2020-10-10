import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:intl/intl.dart';

class WeeklyData {
  DateTime datetime;
  int length;
  Map<String, int> ratioList;
  int meanRatio;
  int meanSuccess;
  int upRatio;

  WeeklyData(List<DailyReport> weeklyReport, String todaysDate) {
    this.datetime = DateTime.parse(todaysDate);
    this.length = weeklyReport.length;
    // Init ratioTmpList
    Map<DateTime, int> ratioTmpList = Map();
    for (int i = 0; i < 7; i++) {
      // String dtString =
      //     DateFormat('EEE').format(datetime.subtract(Duration(days: i)));
      ratioTmpList[datetime.subtract(Duration(days: i))] = 0;
    }
    // MyLogger.debug('parse weekly init ratioTmpList : $ratioTmpList');
    // Compute statistics
    int sumCount = 0;
    int sumSuccess = 0;
    for (int i = 0; i < length; i++) {
      // Set ratioTmpList by report's date and ratio value
      int ratio = (weeklyReport[i].ratio * 100).toInt();
      DateTime dt = DateTime.parse(weeklyReport[i].date);
      if (ratioTmpList.containsKey(dt)) {
        ratioTmpList[dt] = ratio;
      } else {
        MyLogger.error('dt is invalid : $dt');
      }
      // Compute mean values
      sumCount += weeklyReport[i].count;
      sumSuccess += weeklyReport[i].success;
      // MyLogger.debug('sumCount = $sumCount');
      // MyLogger.debug('sumSuccess = $sumSuccess');
    }
    this.upRatio =
        (weeklyReport[0].ratio - weeklyReport[length - 1].ratio).toInt() *
            100; // Not sorted
    this.meanRatio = (sumSuccess * 100) ~/ sumCount;
    this.meanSuccess = sumSuccess ~/ length;
    // MyLogger.debug('last ratioTmpList : $ratioTmpList');
    MyLogger.debug('last meanRatio : $meanRatio');
    MyLogger.debug('last meanSuccess : $meanSuccess');
    MyLogger.debug('last upRatio : $upRatio');
    ratioList = ratioTmpList.map((key, value) {
      return MapEntry(DateFormat('EEE').format(key), value);
    });
    MyLogger.debug('last ratioList : $ratioList');
  }
}
