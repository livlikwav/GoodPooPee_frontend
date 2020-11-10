import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';

import 'chart_indicator.dart';

class DailyPieChart extends StatefulWidget {
  DailyPieChart(this.ratio);
  final double ratio;

  @override
  State<StatefulWidget> createState() => _DailyPieChartState();
}

class _DailyPieChartState extends State<DailyPieChart> {
  // model
  double successRatio;
  double failRatio;
  // to set touch interaction
  int touchedIndex;
  // chart settings >> fail to Indicator lint
  // Color successColor = Colors.orange;
  // Color failColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    successRatio = widget.ratio * 100;
    failRatio = 100 - successRatio;

    return AspectRatio(
      aspectRatio: 1.3,
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
        child: Row(
          children: <Widget>[
            SizedBox(
              height: getBlockSizeVertical(2),
            ),
            Expanded(
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                          pieTouchResponse.touchInput is FlPanEnd) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: getBlockSizeHorizontal(10),
                  sections: showingSections(),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: Colors.orange,
                  text: '성공',
                  isSquare: false,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: AppColors.primaryColor,
                  text: '실패',
                  isSquare: false,
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
            SizedBox(
              width: getBlockSizeHorizontal(2),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    if (successRatio == 100.0) {
      return List.generate(1, (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.orange,
              value: successRatio,
              title: successRatio.toInt().toString() + '%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          default:
            return null;
        }
      });
    } else {
      return List.generate(2, (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.orangeAccent,
              value: successRatio,
              title: successRatio.toInt().toString() + '%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: AppColors.primaryColor,
              value: failRatio,
              title: failRatio.toInt().toString() + '%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          default:
            return null;
        }
      });
    }
  }
}
