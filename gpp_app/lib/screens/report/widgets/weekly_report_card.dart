import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/screens/report/async/parsing_weekly.dart';
import 'package:gpp_app/screens/report/components/empty_card.dart';
import 'package:gpp_app/screens/report/components/percent_card.dart';
import 'package:gpp_app/screens/report/components/stat_card.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/screens/report/components/weekly_bar_chart.dart';
// import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';

class WeeklyReportCard extends StatefulWidget {
  final Future<List<DailyReport>> weeklyReport;
  final String todaysDate;
  WeeklyReportCard(this.weeklyReport, this.todaysDate);

  @override
  State<StatefulWidget> createState() => _WeeklyReportCardState();
}

class _WeeklyReportCardState extends State<WeeklyReportCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
        // border: Border.all(
        //   color: Theme.of(context).primaryColor,
        // ),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      // width: getBlockSizeHorizontal(100),
      height: getBlockSizeVertical(70),
      child: FutureBuilder(
        future: widget.weeklyReport,
        builder:
            (BuildContext context, AsyncSnapshot<List<DailyReport>> snapshot) {
          Widget child;

          // Future complete with data
          if (snapshot.hasData) {
            child = _getCardBody(snapshot.data, widget.todaysDate);
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

Column _getCardBody(List<DailyReport> weeklyReport, String todaysDate) {
  WeeklyData(weeklyReport, todaysDate);
  // Return widget
  return Column(
    children: <Widget>[
      Row(
        children: [
          statCard(
            '주간 배변훈련 리포트',
            'YYYY.MM.DD - YYYY.MM.DD',
            Colors.white,
            titleLogo: true,
          ),
        ],
      ),
      Flexible(flex: 3, child: WeeklyBarChart()),
      Row(
        children: [
          statCard(
            'XX.X%',
            '평균 성공률',
            Colors.orangeAccent,
          ),
          statCard(
            'XX회',
            '평균 성공 횟수',
            Colors.orangeAccent,
          ),
        ],
      ),
      Row(
        children: [
          statCard(
            '훈련 진척도',
            '1주일 간 최대 - 최소 성공률',
            Colors.white,
            flex: 3,
          ),
          percentCard(
            Icons.arrow_upward,
            'XX.X%',
            Colors.orange,
            Colors.white,
          ),
        ],
      ),
    ],
  );
}
