import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/components/percent_card.dart';
import 'package:gpp_app/screens/report/components/stat_card.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/screens/report/components/weekly_bar_chart.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:intl/intl.dart';

class WeeklyReportCard extends StatefulWidget {
  final Future<List<DailyReport>> weeklyReport;
  final String todaysDate;
  WeeklyReportCard(this.weeklyReport, this.todaysDate);

  @override
  State<StatefulWidget> createState() => _WeeklyReportCardState();
}

class _WeeklyReportCardState extends State<WeeklyReportCard> {
  // Avoid crush of layout whenever screen re-build
  double _boxRadius;

  @override
  void initState() {
    _boxRadius = getBlockSizeHorizontal(5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_boxRadius),
        color: AppColors.backgroundColor,
      ),
      padding: const EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: widget.weeklyReport,
        builder:
            (BuildContext context, AsyncSnapshot<List<DailyReport>> snapshot) {
          Widget child;

          // Future complete with data
          if (snapshot.hasData) {
            child = _getCardBody(WeeklyData(snapshot.data, widget.todaysDate));
            // Future complete with error
          } else if (snapshot.hasError) {
            DioError error = snapshot.error;
            if (error.response != null && error.response.statusCode == 404) {
              child = EmptyCard(
                text: '이번주 배변 기록이 존재하지 않습니다.',
              );
            } else {
              child = EmptyCard(
                text: '데이터를 불러오는 과정에서 오류가 발생하였습니다.',
              );
            }
            // Future incomplete
          } else {
            child = WaitingCard(
              text: '데이터를 불러오는 중입니다.',
            );
          }

          return child;
        },
      ),
    );
  }
}

Column _getCardBody(WeeklyData weeklyData) {
  String dtString = DateFormat('yyyy-MM-dd')
          .format(weeklyData.datetime.subtract(Duration(days: 6))) +
      ' - ' +
      DateFormat('yyyy-MM-dd').format(weeklyData.datetime);
  // Return widget
  return Column(
    children: <Widget>[
      // statCard(
      //   '주간 배변훈련 리포트',
      //   dtString,
      //   Colors.white,
      //   titleLogo: true,
      // ),
      WeeklyBarChart(weeklyData),
      // Row(
      //   children: [
      //     statCard(
      //       weeklyData.meanRatio.toString() + '%',
      //       '평균 성공률',
      //       Colors.orangeAccent,
      //     ),
      //     statCard(
      //       weeklyData.meanSuccess.toString() + '회',
      //       '평균 성공 횟수',
      //       Colors.orangeAccent,
      //     ),
      //   ],
      // ),
      // Row(
      //   children: [
      //     statCard(
      //       '최고 배변 성공률',
      //       '1주일 동안 제일 기특했던 하루',
      //       Colors.white,
      //       flex: 3,
      //     ),
      //     percentCard(
      //       Icons.check,
      //       weeklyData.maxRatio.toString() + '%',
      //       Colors.orange,
      //       Colors.white,
      //     ),
      //   ],
      // ),
    ],
  );
}
