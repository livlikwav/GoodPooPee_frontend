import 'package:flutter/material.dart';
import 'package:gpp_app/screens/report/components/daily_report_card.dart';
import 'package:gpp_app/screens/report/components/monthly_report_card.dart';
import 'package:gpp_app/screens/report/components/weekly_report_card.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
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
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
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
          )),
    );
  }
}
