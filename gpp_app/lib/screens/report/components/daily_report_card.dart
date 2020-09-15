import 'package:flutter/material.dart';
import 'package:gpp_app/screens/report/components/daily_pie_chart.dart';
import 'package:gpp_app/screens/report/components/percent_card.dart';
import 'package:gpp_app/screens/report/components/stat_card.dart';
import 'package:gpp_app/util/size_config.dart';

class DailyReportCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DailyReportCardState();
}

class _DailyReportCardState extends State<DailyReportCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(10.0),
        // width: getBlockSizeHorizontal(100),
        height: getBlockSizeVertical(70),
        color: Colors.lightBlue,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                statCard(
                  '일간 배변훈련 리포트',
                  'YYYY.MM.DD',
                  Colors.white,
                ),
              ],
            ),
            Flexible(flex: 3, child: DailyPieChart()),
            Row(
              children: [
                statCard(
                  'XX회',
                  '총 배변 횟수',
                  Colors.white,
                ),
                statCard(
                  'XX회',
                  '성공 횟수',
                  Colors.lightGreen,
                ),
              ],
            ),
            Row(
              children: [
                statCard(
                  '훈련 진척도',
                  '당일 성공률 - 전일 성공률',
                  Colors.white,
                  flex: 3,
                ),
                percentCard(
                  Icons.arrow_upward,
                  'XX.X%',
                  Colors.green,
                ),
              ],
            ),
          ],
        ));
  }
}
