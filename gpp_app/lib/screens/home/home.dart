import 'package:add_thumbnail/add_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/provider/daily_report_provider.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/widgets/reports/daily_report_card.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_app_bar.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DailyReportProvider _dailyReportProvider;
  List<String> urlList = [
    "https://youtu.be/vMx6DWiDQUw",
    "https://youtu.be/mnPlK6NR92U",
    "https://youtu.be/_jOkOAZ5ih8",
  ];
  bool isPetNull = true;
  int petId;

  @override
  void initState() {
    this.petId = Provider.of<UserProfile>(context, listen: false).petId;
    _dailyReportProvider = DailyReportProvider(petId);
    _dailyReportProvider.initRecords(context);
    isPetNull = _dailyReportProvider.isPetNull;
    super.initState();
    // getReports(context);
  }

  // void getReports(BuildContext context) async {
  //   // Get pet id
  //   this.petId = Provider.of<UserProfile>(context, listen: false).petId;
  //   this.isReady = true;
  //   MyLogger.debug('isReady: ${this.isReady}');
  //   // Re-render
  //   setState(() {
  //     MyLogger.debug('home screen setState()');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        primary: true,
        appBar: customAppBar(),
        drawer: DrawerMenu(),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: EdgeInsets.all(getBlockSizeHorizontal(7)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '오늘의 배변 노트',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.more_horiz,
                            color: AppColors.accentColor,
                          ),
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(Routes.report),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: isPetNull
                          // Pet doesnt exists
                          ? EmptyCard(
                              text: '반려견 데이터가 존재하지 않습니다.',
                            )
                          // Pet exists
                          : DailyReportCard(_dailyReportProvider.dailyReport),
                    ),
                    Text(
                      '부모 참고서',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset: Offset(2, 2),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: MediaListView(
                            titleTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .fontSize),

                            titleTextBackGroundColor: Colors.white,
                            // overlayChild: Icon(Icons.save),
                            urls: urlList,
                            // onPressed: (url) {
                            //   print(url);
                            // },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
