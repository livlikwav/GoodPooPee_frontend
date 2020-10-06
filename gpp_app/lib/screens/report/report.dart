import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/screens/report/components/daily_report_card.dart';
import 'package:gpp_app/screens/report/components/empty_card.dart';
import 'package:gpp_app/screens/report/components/monthly_report_card.dart';
import 'package:gpp_app/screens/report/components/weekly_report_card.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isReady = false;
  bool isPetNull = true;
  bool isReportNull = true;
  final DioClient dioClient = DioClient(Dio());
  DateTime selectedDateTime;
  int petId;
  Future<DailyReport> dailyReport;
  // Future<WeeklyReport> weeklyReport;
  // Future<MonthlyReport> monthlyReport;

  @override
  void initState() {
    super.initState();
    // Get today's date (default)
    selectedDateTime = DateTime.now();
    developer.log(
      'Present datetime is $selectedDateTime',
      name: 'DEBUG',
      level: 10,
    );
    getReports();
  }

  void getReports() async {
    developer.log(
      'Start getReports()',
      name: 'DEBUG',
      level: 10,
    );
    // Get pet id
    final prefs = await SharedPreferences.getInstance();
    this.petId = prefs.getInt('petId');
    this.isReady = true;
    // Check existency
    if (petId != null) {
      developer.log(
        'Pet id is $petId',
        name: 'DEBUG',
        level: 10,
      );
      isPetNull = false;
      // Get report models from server
      dailyReport = getDailyReport();
    } else {
      developer.log(
        'Pet id is empty',
        name: 'DEBUG',
        level: 10,
      );
      isPetNull = true;
    }
    // Re-render
    setState(() {});
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
          ? isPetNull
              ? EmptyCard(
                  text: '반려견 데이터가 존재하지 않습니다.',
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
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<int> getPetId() async {
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('petId');
    return id;
  }

  Future<DailyReport> getDailyReport() async {
    Response response;
    // server/pet/report/daily GET
    // path: pet_id
    // query: day_date
    try {
      response = await dioClient.get(
        DioClient.server_url + 'pet/' + petId.toString() + '/report/daily',
        queryParameters: {
          'timestamp': selectedDateTime.toString(),
        },
      );
      developer.log(
        'GET daily report, request url : ${DioClient.server_url + 'pet/' + petId.toString() + '/report/daily'}',
        name: 'DEBUG',
        level: 10,
      );
      // Handling exception
    } on DioError catch (e) {
      if (e.response != null) {
        developer.log(
          'GET daily report successed. Status code is ${e.response.statusCode}',
          name: 'ERROR',
          level: 10,
        );
        return null;
      } else {
        developer.log(
          'GET daily report successed. Error.response is null.\n${e.request}\n${e.message}',
          name: 'ERROR',
          level: 10,
        );
        return null;
      }
    }
    // GET Successed
    if (response != null && response.statusCode == 200) {
      developer.log(
        'GET daily report successed',
        name: 'DEBUG',
        level: 10,
      );

      // DEBUG==================
      print(response.data);

      // Parse json to return value
      return DailyReport.fromJson(response.data);
    } else {
      // response == null (server response is invalid)
      return null;
    }
  }

  void getMonthlyReport() async {
    Response response;
    // server/pet/report/daily GET
    // path: pet_id
    // query: day_date
    // try{
    // response = await dioClient.get();
    // }
  }
}
