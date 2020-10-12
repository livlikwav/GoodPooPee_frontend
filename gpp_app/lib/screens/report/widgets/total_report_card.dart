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
import 'package:intl/intl.dart';

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
            child = _getCardBody(TotalData(snapshot.data));
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

Column _getCardBody(TotalData totalData) {
  final String titleString = totalData.lastDate + '월';
  final String meanRatioString = totalData.meanRatio.toString() + '%';
  final String meanSuccessString = totalData.meanSuccess.toString() + '회';
  final String infoString =
      totalData.firstDate + '월부터 ' + totalData.periodMonth.toString() + '개월째';
  final String progressString = totalData.progressRatio != 999
      ? totalData.progressRatio.toString() + '%'
      // If it is first month, progress = meanRatio (it start from 0%)
      : totalData.meanRatio.toString() + '%';

  return Column(
    children: <Widget>[
      Row(
        children: [
          statCard(
            '월간 배변훈련 리포트',
            titleString,
            Colors.white,
            titleLogo: true,
          ),
        ],
      ),
      Flexible(flex: 3, child: TotalLineChart(totalData)),
      Row(
        children: [
          statCard(
            meanRatioString,
            '평균 성공률',
            Colors.orangeAccent,
          ),
          statCard(
            meanSuccessString,
            '평균 성공 횟수',
            Colors.orangeAccent,
          ),
        ],
      ),
      Row(
        children: [
          statCard(
            '훈련 진척도',
            infoString,
            Colors.white,
            flex: 3,
          ),
          percentCard(
            Icons.arrow_upward,
            progressString,
            Colors.orange,
            Colors.white,
          ),
        ],
      ),
    ],
  );
}
