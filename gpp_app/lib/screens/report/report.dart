import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/screens/report/async/get_daily_report.dart';
import 'package:gpp_app/screens/report/components/daily_report_card.dart';
import 'package:gpp_app/screens/report/components/empty_card.dart';
import 'package:gpp_app/screens/report/components/monthly_report_card.dart';
import 'package:gpp_app/screens/report/components/weekly_report_card.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'async/get_monthly_report.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isReady = false;
  bool isPetNull = true;
  bool isReportNull = true;
  DateTime selectedDateTime;
  int petId;
  Future<DailyReport> dailyReport;
  // Future<WeeklyReport> weeklyReport;
  Future<MonthlyReport> monthlyReport;

  @override
  void initState() {
    super.initState();
    // Get today's date (default)
    selectedDateTime = DateTime.now();
    MyLogger.debug('Present datetime is $selectedDateTime');
    getReports();
  }

  void getReports() async {
    MyLogger.info('Start getReports()');
    // Get pet id
    final prefs = await SharedPreferences.getInstance();
    this.petId = prefs.getInt('petId');
    this.isReady = true;
    MyLogger.debug('isReady: ${this.isReady}');
    // Check that pet exists
    if (petId != null) {
      isPetNull = false;
      MyLogger.info('Pet id is $petId');
      // Get report models from server
      dailyReport = getDailyReport(
        DioClient.server_url + 'pet/' + petId.toString() + '/report/daily',
        '2015-08-09',
        // selectedDateTime.toString(),
      );
      monthlyReport = getMonthlyReport(
        DioClient.server_url + 'pet/' + petId.toString() + '/report/monthly',
        '2015-08-09',
        // selectedDateTime.toString(),
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
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('배변훈련 리포트')),
      drawer: DrawerMenu(),
      body: _buildBody(context),
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
              : isReportNull
                  ? EmptyCard(
                      text: '훈련 데이터가 존재하지 않습니다.',
                    )
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
                            DailyReportCard(),
                            WeeklyReportCard(),
                            MonthlyReportCard(),
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
