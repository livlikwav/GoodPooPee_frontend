import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
import 'package:gpp_app/widgets/shadow_container.dart';
import 'package:intl/intl.dart';

class NoticeWidget extends StatefulWidget {
  NoticeWidget(this.weeklyReport);
  final Future<List<DailyReport>> weeklyReport;
  @override
  _NoticeWidgetState createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  final String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        child: FutureBuilder(
          future: widget.weeklyReport,
          builder: (BuildContext context,
              AsyncSnapshot<List<DailyReport>> snapshot) {
            Widget child;

            // Future complete with data
            if (snapshot.hasData) {
              WeeklyData weeklyData = WeeklyData(snapshot.data, todaysDate);
              child = Text(
                _getNoticeText(weeklyData.meanRatio),
              );
              // Future complete with error
            } else if (snapshot.hasError) {
              DioError error = snapshot.error;
              if (error.response != null && error.response.statusCode == 404) {
                child = Text('WOW');
              } else {
                child = Text('WOW');
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
      ),
    );
  }
}

String _getNoticeText(int ratio) {
  const List<String> strList = [
    '수',
    '우',
    '미',
    '양',
    '가',
  ];
  // Ratio Check
  if (ratio < 0 || ratio > 100) {
    return '부모님 학생 상태가 좀 이상한 것 같습니다.';
  }

  // switch case
  if (ratio >= 80) {
    return strList[0];
  } else if (ratio >= 60) {
    return strList[1];
  } else if (ratio >= 40) {
    return strList[2];
  } else if (ratio >= 20) {
    return strList[3];
  } else {
    // 0 ~ 20
    return strList[4];
  }
}
