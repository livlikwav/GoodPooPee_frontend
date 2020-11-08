import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/services/report/parsing_weekly.dart';
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
              child = _getCardBody();
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

  Widget _getCardBody() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('1'),
          Text('2'),
          Text('3'),
        ],
      ),
    );
  }
}
