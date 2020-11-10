import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/screens/report/components/weekly_bar_chart.dart';
import 'package:gpp_app/widgets/shadow_container.dart';

class WeeklyReportCard extends StatefulWidget {
  final Future<List<DailyReport>> weeklyReport;
  final String todaysDate;
  WeeklyReportCard(this.weeklyReport, this.todaysDate);

  @override
  State<StatefulWidget> createState() => _WeeklyReportCardState();
}

class _WeeklyReportCardState extends State<WeeklyReportCard> {
  // Avoid crush of layout whenever screen re-build

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
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
                text: '오류',
              );
            }
            // Future incomplete
          } else {
            child = WaitingCard();
          }

          return child;
        },
      ),
    );
  }
}

Widget _getCardBody(WeeklyData weeklyData) {
  return Column(
    children: <Widget>[
      WeeklyBarChart(weeklyData),
    ],
  );
}
