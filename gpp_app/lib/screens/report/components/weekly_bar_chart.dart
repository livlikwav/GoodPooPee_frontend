import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
import 'package:gpp_app/util/kst_weekday.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:intl/intl.dart';

class WeeklyBarChart extends StatefulWidget {
  final WeeklyData weeklyData;
  WeeklyBarChart(this.weeklyData);

  // final List<Color> availableColors = [
  //   AppColors.primaryColor.withOpacity(0.2),
  //   AppColors.primaryColor.withOpacity(0.4),
  //   AppColors.primaryColor.withOpacity(0.6),
  //   AppColors.primaryColor.withOpacity(0.8),
  //   AppColors.primaryColor.withOpacity(1.0),
  // ];

  @override
  _WeeklyBarChartState createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  final Color barBackgroundColor = AppColors.primaryColor.withOpacity(0.3);
  // final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex;
  // bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.backgroundColor,
            ),
            margin: EdgeInsets.all(getBlockSizeHorizontal(2)),
            padding: EdgeInsets.all(getBlockSizeHorizontal(2)),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: AppColors.primaryColor),
                children: [
                  TextSpan(
                    text: '평균 성공률 ',
                  ),
                  TextSpan(
                    text: '${widget.weeklyData.meanRatio}% ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '최고 ',
                  ),
                  TextSpan(
                    text: '${widget.weeklyData.maxRatio}%',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      15.0,
                      0.0,
                      15.0,
                      15.0,
                    ),
                    child: BarChart(
                      mainBarData(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = AppColors.primaryColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? barBackgroundColor : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(7, (i) {
      String dtString =
          DateFormat('EEE').format(widget.weeklyData.datetimeList[6 - i]);
      double value = widget.weeklyData.ratioList[dtString].toDouble();
      // MyLogger.debug('value = $value');
      Color barColor;
      if (value > 66) {
        barColor = Colors.green;
      } else if (value > 33) {
        barColor = Colors.lightGreen;
      } else {
        barColor = Colors.yellow;
      }
      return makeGroupData(
        i,
        widget.weeklyData.ratioList[dtString].toDouble(),
        isTouched: i == touchedIndex,
        barColor: barColor,
      );
    });
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: AppColors.accentColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = getKstWeekday(widget.weeklyData.datetimeList[6]);
                  break;
                case 1:
                  weekDay = getKstWeekday(widget.weeklyData.datetimeList[5]);
                  break;
                case 2:
                  weekDay = getKstWeekday(widget.weeklyData.datetimeList[4]);
                  break;
                case 3:
                  weekDay = getKstWeekday(widget.weeklyData.datetimeList[3]);
                  break;
                case 4:
                  weekDay = getKstWeekday(widget.weeklyData.datetimeList[2]);
                  break;
                case 5:
                  weekDay = getKstWeekday(widget.weeklyData.datetimeList[1]);
                  break;
                case 6:
                  weekDay = getKstWeekday(widget.weeklyData.datetimeList[0]);
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.white));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
            // fontWeight: FontWeight.bold,
          ),
          margin: 10,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return getKstWeekday(widget.weeklyData.datetimeList[6]);
              case 1:
                return getKstWeekday(widget.weeklyData.datetimeList[5]);
              case 2:
                return getKstWeekday(widget.weeklyData.datetimeList[4]);
              case 3:
                return getKstWeekday(widget.weeklyData.datetimeList[3]);
              case 4:
                return getKstWeekday(widget.weeklyData.datetimeList[2]);
              case 5:
                return getKstWeekday(widget.weeklyData.datetimeList[1]);
              case 6:
                return getKstWeekday(widget.weeklyData.datetimeList[0]);
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          interval: 5,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
