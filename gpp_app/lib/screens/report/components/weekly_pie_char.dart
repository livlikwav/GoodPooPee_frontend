import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
import 'package:gpp_app/util/size_config.dart';

class WeeklyPieChart extends StatefulWidget {
  WeeklyPieChart(this.weeklyData);
  final WeeklyData weeklyData;
  @override
  _WeeklyPieChartState createState() => _WeeklyPieChartState();
}

class _WeeklyPieChartState extends State<WeeklyPieChart> {
  int touchedIndex;
  Color val1Color;

  final List<Color> colorList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    widget.weeklyData.meanRatio == 100
        ? val1Color = colorList[4]
        : val1Color = colorList[widget.weeklyData.meanRatio ~/ 20];
    return AspectRatio(
      aspectRatio: 1,
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
            centerSpaceRadius: 40,
            sections: showingSections(widget.weeklyData, val1Color)),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
    WeeklyData weeklyData,
    Color val1Color,
  ) {
    double val1 = weeklyData.meanRatio.toDouble();
    double val2 = 100 - weeklyData.meanRatio.toDouble();
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      // final double fontSize = isTouched ? 25 : 16;
      final double val1Radius =
          isTouched ? getBlockSizeHorizontal(4) : getBlockSizeHorizontal(3);
      final double val2Radius =
          isTouched ? getBlockSizeHorizontal(3) : getBlockSizeHorizontal(2);
      switch (i) {
        case 1:
          return PieChartSectionData(
            color: val1Color,
            value: val1,
            showTitle: false,
            // title: '${val1.toStringAsFixed(0)}%',
            radius: val1Radius,
            // titleStyle: TextStyle(
            //   fontSize: fontSize,
            //   fontWeight: FontWeight.bold,
            //   color: Colors.black,
            // ),
          );
        case 0:
          return PieChartSectionData(
            color: AppColors.primaryColor.withOpacity(0.5),
            value: val2,
            showTitle: false,
            // title: '${val2.toStringAsFixed(0)}%',
            radius: val2Radius,
            // titleStyle: TextStyle(
            //   fontSize: fontSize,
            //   fontWeight: FontWeight.bold,
            //   color: const Color(0xffffffff),
            // ),
          );
        default:
          return null;
      }
    });
  }
}
