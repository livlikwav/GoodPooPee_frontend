import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/constants/layouts.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/screens/report/components/grade_card.dart';
import 'package:gpp_app/screens/report/components/notice.dart';
import 'package:gpp_app/widgets/custom_app_bar.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/widgets/total_report_card.dart';
import 'package:gpp_app/screens/report/widgets/weekly_report_card.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:gpp_app/services/report/get_weekly_report.dart';
import 'package:gpp_app/services/report/get_total_report.dart';

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
  Future<List<DailyReport>> weeklyReport;
  Future<List<MonthlyReport>> totalReport;

  @override
  void initState() {
    super.initState();
    // Get today's date (default)
    todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    //DEBUG!!!!!!!!!!!!!
    // todaysDate = DateFormat('yyyy-MM-dd')
    //     .format(DateTime.now().subtract(Duration(days: 1)));
    //DEBUG!!!!!!!!!!!!!
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
        backgroundColor: AppColors.backgroundColor,
        appBar: customAppBar(
          refreshIcon: IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
            onPressed: () {
              setState(() {
                Navigator.of(context).popAndPushNamed(Routes.report);
              });
            },
          ),
        ),
        drawer: DrawerMenu(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      child: isReady
          // Is ready
          ? isPetNull
              // Pet doesnt exists
              ? EmptyCard(
                  text: '반려견 데이터가 존재하지 않습니다.',
                )
              // Pet exists
              : Padding(
                  padding: EdgeInsets.all(
                    getBlockSizeHorizontal(7),
                  ),
                  child: OrientationBuilder(builder: (context, orientation) {
                    if (orientation == Orientation.landscape) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      // Orientation.portrait
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '성적표',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Layouts.customSpacer(),
                            GradeCard(weeklyReport),
                            Layouts.customSpacer(),
                            Text(
                              '알림장',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Layouts.customSpacer(),
                            NoticeWidget(weeklyReport),
                            Layouts.customSpacer(),
                            Text(
                              '생활 기록부',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Layouts.customSpacer(),
                            WeeklyReportCard(weeklyReport, todaysDate),
                            TotalReportCard(totalReport),
                          ],
                        ),
                      );
                    }
                  }),
                )
          // Not ready
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
