import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/screens/report/async/parsing_total.dart';
import 'package:gpp_app/screens/report/components/empty_card.dart';
import 'package:gpp_app/screens/report/components/percent_card.dart';
import 'package:gpp_app/screens/report/components/stat_card.dart';
import 'package:gpp_app/screens/report/components/total_line_chart.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/util/size_config.dart';

class TotalReportCard extends StatefulWidget {
  final Future<List<MonthlyReport>> totalReport;
  TotalReportCard(this.totalReport);
  @override
  State<StatefulWidget> createState() => _TotalReportCardState();
}

class _TotalReportCardState extends State<TotalReportCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      // width: getBlockSizeHorizontal(100),
      height: getBlockSizeVertical(70),
      // child: _getCardBody(),
      child: FutureBuilder(
        future: widget.totalReport,
        builder: (BuildContext context,
            AsyncSnapshot<List<MonthlyReport>> snapshot) {
          Widget child;

          // Future complete with data
          if (snapshot.hasData) {
            // child = _getCardBody(MonthlyData(snapshot.data, widget.todaysDate));
            child = _getCardBody();
            TotalData(snapshot.data);
            // Future complete with error
          } else if (snapshot.hasError) {
            DioError error = snapshot.error;
            if (error.response != null && error.response.statusCode == 404) {
              child = EmptyCard(
                text: '전체 배변 기록이 존재하지 않습니다.',
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

Column _getCardBody() {
  return Column(
    children: <Widget>[
      Row(
        children: [
          statCard(
            '전체 월간 배변훈련 리포트',
            'YYYY.MM.DD',
            Colors.white,
            titleLogo: true,
          ),
        ],
      ),
      Flexible(flex: 3, child: TotalLineChart()),
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
            '시작일: YYYY-MM-DD, XX일째',
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
