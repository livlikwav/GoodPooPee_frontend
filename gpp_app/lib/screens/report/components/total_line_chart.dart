import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/screens/report/async/parsing_total.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:intl/intl.dart';

class TotalLineChart extends StatefulWidget {
  final TotalData totalData;
  TotalLineChart(this.totalData);
  @override
  _TotalLineChartState createState() => _TotalLineChartState();
}

class _TotalLineChartState extends State<TotalLineChart> {
  ChartModel model;

  List<Color> gradientColors = [
    AppColors.orange[200],
    AppColors.orange[800],
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    // init model
    model = ChartModel(widget.totalData);
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
        bottomTitles: model.xSideTitles,
        leftTitles: model.ySideTitles,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: model.axisConstraints['minX'],
      maxX: model.axisConstraints['maxX'],
      minY: model.axisConstraints['minY'],
      maxY: model.axisConstraints['maxY'],
      lineBarsData: [
        LineChartBarData(
          spots: model.chartDataSpots,
          isCurved: true,
          curveSmoothness: 0.1,
          colors: [
            Colors.orangeAccent,
          ],
          barWidth: 7,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
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
      lineTouchData: LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: model.xSideTitles,
        leftTitles: model.ySideTitles,
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: model.axisConstraints['minX'],
      maxX: model.axisConstraints['maxX'],
      minY: model.axisConstraints['minY'],
      maxY: model.axisConstraints['maxY'],
      lineBarsData: [
        LineChartBarData(
          spots: model.avgDataSpots,
          isCurved: true,
          colors: [Colors.orangeAccent],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
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

class ChartModel {
  // Members
  List reverseIndex;
  List<FlSpot> chartDataSpots;
  List<FlSpot> avgDataSpots;
  SideTitles xSideTitles;

  final Map<String, double> axisConstraints = {
    'minX': 0.0,
    // X: 0, 1, 2, 3, 4, 5
    'maxX': 5.0,
    'minY': 0.0,
    'maxY': 100.0,
  };
  final ySideTitles = SideTitles(
    showTitles: false,
  );

  ChartModel(TotalData data) {
    // Set 6.0 to list up 0.0 ~ 5.0
    int maxX = axisConstraints['maxX'].toInt() + 1;
    // Init reverseIndex
    reverseIndex = List.generate(maxX, (index) {
      return maxX - index - 1;
    });
    // Init chartDataSpots
    chartDataSpots = List.generate(data.length, (index) {
      return FlSpot(
        (reverseIndex[index]).toDouble(),
        data.ratioMap[data.dtList[index]].toDouble(),
      );
    });
    // Init avgDataSpots
    avgDataSpots = _getAvgDataSpots(chartDataSpots);
    // Init xSideTitles
    xSideTitles = SideTitles(
      showTitles: true,
      textStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      getTitles: (value) {
        int val = value.toInt();
        // last datetime is today's month
        DateTime dt = data.dtList[data.length - 1];
        DateTime targetDt =
            new DateTime(dt.year, dt.month - reverseIndex[val], dt.day);
        return DateFormat('yy-MM').format(targetDt);
      },
      margin: 15,
    );
  }

  List<FlSpot> _getAvgDataSpots(List<FlSpot> myChartDataSpots) {
    double sum = 0;
    myChartDataSpots.forEach((spot) => sum = sum + spot.y);
    double meanY = (sum ~/ myChartDataSpots.length).toDouble();
    List<FlSpot> avgSpots = [];
    myChartDataSpots.forEach((spot) => avgSpots.add(FlSpot(spot.x, meanY)));
    return avgSpots;
  }
}
