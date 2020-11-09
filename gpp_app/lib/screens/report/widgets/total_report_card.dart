import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/services/report/parsing_total.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/components/total_line_chart.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/widgets/shadow_container.dart';

class TotalReportCard extends StatefulWidget {
  final Future<List<MonthlyReport>> totalReport;
  TotalReportCard(this.totalReport);
  @override
  State<StatefulWidget> createState() => _TotalReportCardState();
}

class _TotalReportCardState extends State<TotalReportCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
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
                text: '반려견의 배변훈련 통계가 존재하지 않습니다.',
              );
            } else {
              child = EmptyCard(
                text: '데이터를 불러오는 과정에서 오류가 발생하였습니다.',
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

Widget _getCardBody(TotalData totalData) {
  // final String titleString = totalData.lastDate + '월';
  // final String meanRatioString = totalData.meanRatio.toString() + '%';
  // final String meanSuccessString = totalData.meanSuccess.toString() + '회';
  // final String infoString =
  //     totalData.firstDate + '월부터 ' + totalData.periodMonth.toString() + '개월째';
  // final String progressString = totalData.progressRatio != 999
  //     ? totalData.progressRatio.toString() + '%'
  //     // If it is first month, progress = meanRatio (it start from 0%)
  //     : totalData.meanRatio.toString() + '%';

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      TotalLineChart(totalData),
    ],
  );
}
