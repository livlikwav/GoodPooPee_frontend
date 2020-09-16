import 'package:flutter/material.dart';
import 'package:gpp_app/screens/report/components/percent_card.dart';
import 'package:gpp_app/screens/report/components/stat_card.dart';
import 'package:gpp_app/screens/report/components/weekly_bar_chart.dart';
import 'package:gpp_app/util/size_config.dart';

class WeeklyReportCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeeklyReportCardState();
}

class _WeeklyReportCardState extends State<WeeklyReportCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(10.0),
        // width: getBlockSizeHorizontal(100),
        height: getBlockSizeVertical(70),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                statCard(
                  '주간 배변훈련 리포트',
                  'YYYY.MM.DD - YYYY.MM.DD',
                  Colors.white,
                ),
              ],
            ),
            Flexible(flex: 3, child: WeeklyBarChart()),
            Row(
              children: [
                statCard(
                  'XX.X%',
                  '평균 성공률',
                  Colors.orangeAccent,
                ),
                statCard(
                  'XX회',
                  '평균 성공 횟수',
                  Colors.orangeAccent,
                ),
              ],
            ),
            Row(
              children: [
                statCard(
                  '훈련 진척도',
                  '1주일 간 최대 - 최소 성공률',
                  Colors.white,
                  flex: 3,
                ),
                percentCard(
                  Icons.arrow_upward,
                  'XX.X%',
                  Colors.orange,
                  Colors.white,
                ),
              ],
            ),
          ],
        ));
  }
}
