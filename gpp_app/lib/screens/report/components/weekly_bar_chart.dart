import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
import 'package:gpp_app/util/kst_weekday.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:intl/intl.dart';

class WeeklyBarChart extends StatefulWidget {
  final WeeklyData weeklyData;
  WeeklyBarChart(this.weeklyData);

  final List<Color> availableColors = [
    AppColors.primaryColor.withOpacity(0.2),
    AppColors.primaryColor.withOpacity(0.4),
    AppColors.primaryColor.withOpacity(0.6),
    AppColors.primaryColor.withOpacity(0.8),
    AppColors.primaryColor.withOpacity(1.0),
  ];

  @override
  _WeeklyBarChartState createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  final Color barBackgroundColor = Colors.white;
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
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
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_circle_filled,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();
                      }
                    });
                  },
                ),
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
                          text: '평균 ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${widget.weeklyData.meanRatio}% ',
                        ),
                        TextSpan(
                          text: '최고 ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${widget.weeklyData.maxRatio}%',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      return makeGroupData(
        i,
        widget.weeklyData.ratioList[dtString].toDouble(),
        isTouched: i == touchedIndex,
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
          textStyle: TextStyle(color: AppColors.primaryColor, fontSize: 14),
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

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: AppColors.primaryColor, fontSize: 14),
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
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(70).toDouble() + 30,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(70).toDouble() + 30,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(70).toDouble() + 30,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(70).toDouble() + 30,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(70).toDouble() + 30,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(70).toDouble() + 30,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(70).toDouble() + 30,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}
