import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class DailyReportCard extends StatefulWidget {
  final Future<DailyReport> dailyReport;
  DailyReportCard(this.dailyReport);

  @override
  State<StatefulWidget> createState() => _DailyReportCardState();
}

class _DailyReportCardState extends State<DailyReportCard> {
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: Offset(2, 2),
            ),
          ],
          color: Colors.white,
        ),
        child: FutureBuilder(
          future: widget.dailyReport,
          builder: (BuildContext context, AsyncSnapshot<DailyReport> snapshot) {
            Widget child;

            // Future complete with data
            if (snapshot.hasData) {
              child = _getCardBody(context, snapshot.data);
              // Future complete with error
            } else if (snapshot.hasError) {
              DioError error = snapshot.error;
              if (error.response != null && error.response.statusCode == 404) {
                child = _getCardBody(context, null);
                // child = EmptyCard(
                //   text: '오늘의 배변 기록이 존재하지 않습니다.',
                // );
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
      ),
    );
  }
}

Widget _getCardBody(BuildContext context, DailyReport dailyReport) {
  bool isNull;
  bool isVisible;
  if (dailyReport == null) {
    isNull = true;
    isVisible = false;
  } else {
    isNull = false;
    if (dailyReport.ratio > 0.5) {
      isVisible = false;
    } else {
      isVisible = true;
    }
  }
  return Container(
    padding: EdgeInsets.all(getBlockSizeHorizontal(2)),
    child: Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '성공',
                        style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize:
                              Theme.of(context).textTheme.subtitle1.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isNull ? '0회' : '${dailyReport.success.toString()}회',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize:
                                Theme.of(context).textTheme.subtitle1.fontSize),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '총',
                        style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize:
                              Theme.of(context).textTheme.subtitle1.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isNull ? '0회' : '${dailyReport.count.toString()}회',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize:
                                Theme.of(context).textTheme.subtitle1.fontSize),
                      ),
                    ],
                  ),
                ],
              ),
              // Text('WOW'),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: getBlockSizeVertical(12),
                child: LiquidLinearProgressIndicator(
                  value: isNull ? 100.0 : dailyReport.ratio,
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  backgroundColor: Colors.white,
                  borderColor: Colors.white,
                  borderWidth: 5.0,
                  borderRadius: 12.0,
                  direction: Axis.vertical,
                  center: Text(
                    isNull ? '100%' : "${dailyReport.ratio * 100}%",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                      color: isVisible ? AppColors.accentColor : Colors.white,
                    ),
                  ),
                ),
              ),
              // Text(
              //   '성공률',
              //   style: TextStyle(
              //     color: Theme.of(context).textTheme.subtitle1.color,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
        // statCard(
        //   '일간 배변훈련 리포트',
        //   dailyReport.date,
        //   Colors.white,
        //   titleLogo: true,
        // ),
        // DailyPieChart(dailyReport.ratio),
        // Row(
        //   children: [
        //     statCard(
        //       dailyReport.count.toString() + '회',
        //       '총 배변 횟수',
        //       Colors.white,
        //     ),
        //     statCard(
        //       dailyReport.success.toString() + '회',
        //       '성공 횟수',
        //       Colors.orangeAccent,
        //     ),
        //   ],
        // ),
        // Row(
        //   children: [
        //     statCard(
        //       '훈련 진척도',
        //       '당일 성공률 - 전일 성공률',
        //       Colors.white,
        //       flex: 3,
        //     ),
        //     percentCard(
        //       Icons.arrow_upward,
        //       (dailyReport.ratio * 100).toInt().toString() + '%',
        //       Colors.orange,
        //       Colors.white,
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}
