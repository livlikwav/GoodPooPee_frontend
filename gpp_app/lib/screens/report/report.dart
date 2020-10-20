import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/screens/report/async/get_weekly_report.dart';
import 'package:gpp_app/screens/report/widgets/daily_report_card.dart';
import 'package:gpp_app/screens/report/components/empty_card.dart';
import 'package:gpp_app/screens/report/widgets/total_report_card.dart';
import 'package:gpp_app/screens/report/widgets/weekly_report_card.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'async/get_daily_report.dart';
import 'async/get_total_report.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isReady = false;
  bool isPetNull = true;
  bool isReportNull = true;
  String todaysDate;
  int petId;
  Future<DailyReport> dailyReport;
  Future<List<DailyReport>> weeklyReport;
  Future<List<MonthlyReport>> totalReport;

  @override
  void initState() {
    super.initState();
    // Get today's date (default)
    todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // MyLogger.debug('Present datetime is $todaysDate');
    getReports(context);
  }

  void getReports(BuildContext context) async {
    MyLogger.info('Start getReports()');
    // Get pet id
    this.petId = Provider.of<UserProfile>(context, listen: false).petId;
    this.isReady = true;
    MyLogger.debug('isReady: ${this.isReady}');
    // Check that pet exists
    if (petId != null) {
      isPetNull = false;
      MyLogger.info('Pet id is $petId');
      // Get report models from server
      dailyReport = getDailyReport(
        context,
        DioClient.serverUrl + 'pet/' + petId.toString() + '/report/daily',
        todaysDate,
      );
      weeklyReport = getWeeklyReport(
        context,
        DioClient.serverUrl + 'pet/' + petId.toString() + '/report/weekly',
        todaysDate,
      );
      totalReport = getTotalReport(
        context,
        DioClient.serverUrl + 'pet/' + petId.toString() + '/report/total',
      );
    } else {
      isPetNull = true;
      MyLogger.info('Pet id is empty');
    }
    // Re-render
    setState(() {
      MyLogger.debug('report screen setState()');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(title: Text('배변훈련 리포트')),
        drawer: DrawerMenu(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: isReady
          // Is ready
          ? isPetNull
              // Pet doesnt exists
              ? EmptyCard(
                  text: '반려견 데이터가 존재하지 않습니다.',
                )
              // Pet exists
              : Padding(
                  padding: EdgeInsets.fromLTRB(
                    getBlockSizeHorizontal(5),
                    getBlockSizeHorizontal(5),
                    getBlockSizeHorizontal(5),
                    0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        DailyReportCard(dailyReport),
                        WeeklyReportCard(weeklyReport, todaysDate),
                        TotalReportCard(totalReport),
                      ],
                    ),
                  ),
                )
          // Not ready
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
