import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/constants/styles.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/screens/report/components/weekly_pie_char.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/shadow_container.dart';
import 'package:intl/intl.dart';

class GradeCard extends StatefulWidget {
  GradeCard(this.weeklyReport);
  final Future<List<DailyReport>> weeklyReport;
  @override
  _GradeCardState createState() => _GradeCardState();
}

class _GradeCardState extends State<GradeCard> {
  final String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Container(
        width: double.infinity,
        child: FutureBuilder(
          future: widget.weeklyReport,
          builder: (BuildContext context,
              AsyncSnapshot<List<DailyReport>> snapshot) {
            Widget child;

            // Future complete with data
            if (snapshot.hasData) {
              WeeklyData weeklyData = WeeklyData(snapshot.data, todaysDate);
              child = _getCardBody(weeklyData);
              // Future complete with error
            } else if (snapshot.hasError) {
              DioError error = snapshot.error;
              if (error.response != null && error.response.statusCode == 404) {
                child = Text('HES');
              } else {
                child = Text('HES');
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

  Widget _getCardBody(WeeklyData weeklyData) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftPartition(
                      val: '${weeklyData.meanRatio}%',
                      title: '평균 성공률',
                      icon: Icons.check_circle,
                      color: Colors.green.withOpacity(0.5),
                      iconColor: Colors.green,
                    ),
                    leftPartition(
                      val: '${weeklyData.meanSuccess}회',
                      title: '평균 성공 횟수',
                      icon: Icons.check_circle,
                      color: AppColors.primaryColor.withOpacity(0.5),
                      iconColor: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: rightPartition(weeklyData),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: getBlockSizeVertical(2)),
            child: Container(
              color: Colors.grey.withOpacity(0.5),
              width: double.infinity,
              height: getBlockSizeVertical(0.1),
            ),
          ),
          bottomPartition(weeklyData),
        ],
      ),
    );
  }
}

Widget leftPartition(
    {String val, String title, IconData icon, Color color, Color iconColor}) {
  return Row(
    children: [
      Container(
        color: color,
        width: getBlockSizeHorizontal(0.5),
        height: getBlockSizeVertical(5),
      ),
      SizedBox(
        width: getBlockSizeHorizontal(2),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.subtitle2(Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(
                width: getBlockSizeHorizontal(3),
              ),
              Text(
                val,
                style: Styles.subtitle1(Colors.black),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget rightPartition(WeeklyData weeklyData) {
  // DEBUG
  // weeklyData.meanRatio = 19;
  return Stack(
    alignment: Alignment.center,
    children: [
      WeeklyPieChart(weeklyData),
      getGrade(weeklyData.meanRatio),
    ],
  );
}

Widget getGrade(int ratio) {
  final List<String> gradeList = [
    '가',
    '양',
    '미',
    '우',
    '수',
  ];
  final List<Color> colorList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
  ];
  String title;
  Color color;
  ratio == 100 ? title = gradeList[4] : title = gradeList[ratio ~/ 20];
  ratio == 100 ? color = colorList[4] : color = colorList[ratio ~/ 20];
  return Text(
    title,
    style: Styles.grade(color),
  );
}

Widget bottomPartition(WeeklyData weeklyData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalItem(
        color: Colors.green,
        title: '평균 배변 횟수',
        subtitle: '${weeklyData.meanCount}회',
      ),
      verticalItem(
        color: AppColors.primaryColor,
        title: '최고 성공률',
        subtitle: '${weeklyData.maxRatio}%',
      ),
      verticalItem(
        color: Colors.red,
        title: '기간',
        subtitle: '${weeklyData.term}',
      ),
    ],
  );
}

Widget verticalItem({
  Color color = Colors.black,
  @required String title,
  @required String subtitle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Styles.subtitle2(Colors.black),
      ),
      SizedBox(height: getBlockSizeVertical(0.2)),
      Container(
        color: color,
        width: getBlockSizeHorizontal(10),
        height: getBlockSizeVertical(0.2),
      ),
      SizedBox(height: getBlockSizeVertical(0.2)),
      Text(
        subtitle,
        style: Styles.subtitle2(Colors.grey),
      ),
    ],
  );
}
