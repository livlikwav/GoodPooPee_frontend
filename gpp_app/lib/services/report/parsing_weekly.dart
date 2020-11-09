import 'dart:math';

import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:intl/intl.dart';

class WeeklyData {
  DateTime datetime;
  int length;
  List<DateTime> datetimeList;
  Map<String, int> ratioList;
  int meanRatio;
  int meanSuccess;
  int meanCount;
  int maxRatio = 0;
  int minRatio = 100;
  int sumSuccess;
  int sumCount;
  String term;

  WeeklyData(List<DailyReport> weeklyReport, String todaysDate) {
    this.datetime = DateTime.parse(todaysDate);
    this.length = weeklyReport.length;
    // Init lists
    this.datetimeList = List(7);
    Map<DateTime, int> ratioTmpList = Map();
    for (int i = 0; i < 7; i++) {
      DateTime dt = datetime.subtract(Duration(days: i));
      datetimeList[i] = dt;
      ratioTmpList[dt] = 0;
    }
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
      // Compute values
      this.maxRatio = max(maxRatio, ratio);
      this.minRatio = min(minRatio, ratio);
      sumCount += weeklyReport[i].count;
      sumSuccess += weeklyReport[i].success;
    }
    this.sumCount = sumCount;
    this.sumSuccess = sumSuccess;
    this.meanRatio = (sumSuccess * 100) ~/ sumCount;
    this.meanSuccess = sumSuccess ~/ length;
    this.ratioList = ratioTmpList.map((key, value) {
      return MapEntry(DateFormat('EEE').format(key), value);
    });
    this.meanCount = sumCount ~/ length;
    this.term = '${weeklyReport[0].date}\n~${weeklyReport[length - 1].date}';
    // MyLogger.debug('${toString()}');
  }

  @override
  String toString() {
    return 'Parsed weekly report: meanRatio : $meanRatio, meanSuccess : $meanSuccess, maxRatio : $maxRatio, datetimeList : $datetimeList, ratioList : $ratioList';
  }
}
