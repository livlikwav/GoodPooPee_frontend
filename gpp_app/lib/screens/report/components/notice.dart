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
        padding: const EdgeInsets.all(20.0),
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
                _getNoticeText(weeklyData.meanRatio, weeklyData.maxRatio,
                    weeklyData.meanSuccess),
              );
              // Future complete with error
            } else if (snapshot.hasError) {
              DioError error = snapshot.error;
              if (error.response != null && error.response.statusCode == 404) {
                child = Text('오늘은 알림장 내용이 없습니다.');
              } else {
                child = Text('오류');
              }
              // Future incomplete
            } else {
              child = WaitingCard();
            }

            return child;
          },
        ),
      ),
    );
  }
}

String _getNoticeText(int meanRatio, int maxRatio, int meanSuccess) {
  final List<String> strList = [
    '성적이 $meanRatio 점으로 또래들 중에서 매우 우수한 편입니다. 아이가 따로 학원을 다니고 있나요?',
    '요즘 아이가 공부하는 데 재미를 붙인 것 같습니다. 아이가 더 행복하게 공부할 수 있도록 더 맛있는 간식을 주는 건 어떨까요?',
    '아이들은 사랑을 받는만큼 훌륭하게 성장한다고 합니다. 학부모님께서 아이에게 많은 관심과 사랑을 주시길 부탁드립니다.',
    '시작이 반이라고 합니다. 아이가 일주일동안 평균 $meanSuccess 번씩은 성공하고 있습니다. 다음주에는 더 잘할 수 있게 학부모님께서 많은 독려 부탁드립니다.',
    '아직 대소변은 잘 못가리지만 밝고 착한 아이입니다. 아직은 $maxRatio 점이 최고 점수지만, 좋은 아이로 성장할 수 있게 저희도 더 신경쓰겠습니다.',
  ];
  // Ratio Check
  if (meanRatio < 0 || meanRatio > 100) {
    return '부모님 학생 상태가 좀 이상한 것 같습니다.';
  }

  // switch case
  if (meanRatio >= 80) {
    return strList[0];
  } else if (meanRatio >= 60) {
    return strList[1];
  } else if (meanRatio >= 40) {
    return strList[2];
  } else if (meanRatio >= 20) {
    return strList[3];
  } else {
    // 0 ~ 20
    return strList[4];
  }
}
