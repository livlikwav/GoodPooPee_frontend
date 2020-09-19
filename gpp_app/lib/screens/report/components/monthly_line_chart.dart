import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';

class MonthlyLineChart extends StatefulWidget {
  @override
  _MonthlyLineChartState createState() => _MonthlyLineChartState();
}

class _MonthlyLineChartState extends State<MonthlyLineChart> {
  List<Color> gradientColors = [
    AppColors.orange[200],
    AppColors.orange[800],
  ];

  final List<double> axisMinMaxs = [0, 11, 0, 6]; //minX, maxX, minY, maxY

  bool showAvg = false;

  final xSideTitles = SideTitles(
    showTitles: true,
    textStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    ),
    getTitles: (value) {
      switch (value.toInt()) {
        case 2:
          return '7월';
        case 5:
          return '8월';
        case 8:
          return '9월';
      }
      return '';
    },
    margin: 8,
  );

  //Set false
  final ySideTitles = SideTitles(
    showTitles: false,
  );

  List<FlSpot> myChartDataSpots = [
    FlSpot(0, 3),
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 5),
    FlSpot(5, 5),
    FlSpot(6, 3.1),
    FlSpot(7, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
  ];

  List<FlSpot> _getAvgDataSpots(List<FlSpot> myChartDataSpots) {
    double meanY;
    double sum = 0;
    double count = 0;
    myChartDataSpots.forEach((spot) {
      count = count + 1.0;
      sum = sum + spot.y;
    });
    meanY = sum / count;
    List<FlSpot> avgSpots = [];
    myChartDataSpots.forEach((spot) {
      avgSpots.add(FlSpot(spot.x, meanY));
    });
    return avgSpots;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.all(15.0),
          width: getBlockSizeHorizontal(15),
          child: FlatButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              '평균',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? AppColors.orange[600] : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: xSideTitles,
        leftTitles: ySideTitles,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: axisMinMaxs[0],
      maxX: axisMinMaxs[1],
      minY: axisMinMaxs[2],
      maxY: axisMinMaxs[3],
      lineBarsData: [
        LineChartBarData(
          spots: myChartDataSpots,
          isCurved: true,
          colors: [
            Colors.orangeAccent,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: xSideTitles,
        leftTitles: ySideTitles,
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: axisMinMaxs[0],
      maxX: axisMinMaxs[1],
      minY: axisMinMaxs[2],
      maxY: axisMinMaxs[3],
      lineBarsData: [
        LineChartBarData(
          spots: _getAvgDataSpots(myChartDataSpots),
          isCurved: true,
          colors: [Colors.orangeAccent],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
