import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/screens/report/components/daily_pie_chart.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/components/percent_card.dart';
import 'package:gpp_app/screens/report/components/stat_card.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/util/size_config.dart';

class DailyReportCard extends StatefulWidget {
  final Future<DailyReport> dailyReport;
  DailyReportCard(this.dailyReport);

  @override
  State<StatefulWidget> createState() => _DailyReportCardState();
}

class _DailyReportCardState extends State<DailyReportCard> {
  // Avoid crush of layout whenever screen re-build
  double _boxRadius;
  double _boxHeight;
  @override
  void initState() {
    _boxRadius = getBlockSizeHorizontal(5);
    _boxHeight = getBlockSizeVertical(70);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_boxRadius),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      height: _boxHeight,
      child: FutureBuilder(
        future: widget.dailyReport,
        builder: (BuildContext context, AsyncSnapshot<DailyReport> snapshot) {
          Widget child;

          // Future complete with data
          if (snapshot.hasData) {
            child = _getCardBody(snapshot.data);
            // Future complete with error
          } else if (snapshot.hasError) {
            DioError error = snapshot.error;
            if (error.response != null && error.response.statusCode == 404) {
              child = EmptyCard(
                text: '오늘의 배변 기록이 존재하지 않습니다.',
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

Column _getCardBody(DailyReport dailyReport) {
  return Column(
    children: <Widget>[
      Row(
        children: [
          statCard(
            '일간 배변훈련 리포트',
            dailyReport.date,
            Colors.white,
            titleLogo: true,
          ),
        ],
      ),
      Flexible(flex: 3, child: DailyPieChart(dailyReport.ratio)),
      Row(
        children: [
          statCard(
            dailyReport.count.toString() + '회',
            '총 배변 횟수',
            Colors.white,
          ),
          statCard(
            dailyReport.success.toString() + '회',
            '성공 횟수',
            Colors.orangeAccent,
          ),
        ],
      ),
      Row(
        children: [
          statCard(
            '훈련 진척도',
            '당일 성공률 - 전일 성공률',
            Colors.white,
            flex: 3,
          ),
          percentCard(
            Icons.arrow_upward,
            (dailyReport.ratio * 100).toInt().toString() + '%',
            Colors.orange,
            Colors.white,
          ),
        ],
      ),
    ],
  );
}
