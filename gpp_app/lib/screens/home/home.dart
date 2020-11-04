import 'package:add_thumbnail/add_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/monthly_report.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/screens/home/components/favorite_button.dart';
import 'package:gpp_app/screens/report/widgets/total_report_card.dart';
import 'package:gpp_app/services/report/get_total_report.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_app_bar.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/widgets/rounded_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> urlList = [
    "https://youtu.be/vMx6DWiDQUw",
    "https://youtu.be/mnPlK6NR92U",
    "https://youtu.be/_jOkOAZ5ih8",
  ];
  bool isReady = false;
  bool isPetNull = true;
  bool isReportNull = true;
  String todaysDate;
  int petId;
  Future<List<MonthlyReport>> totalReport;

  @override
  void initState() {
    todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
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
      MyLogger.debug('home screen setState()');
    });
  }

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
                          '월간 배변 훈련 그래프',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.play_circle_filled,
                            color: AppColors.accentColor,
                          ),
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(Routes.report),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: isReady
                          // Is ready
                          ? isPetNull
                              // Pet doesnt exists
                              ? EmptyCard(
                                  text: '반려견 데이터가 존재하지 않습니다.',
                                )
                              // Pet exists
                              : OrientationBuilder(
                                  builder: (context, orientation) {
                                  if (orientation == Orientation.landscape) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    // Orientation.portrait
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          TotalReportCard(totalReport),
                                        ],
                                      ),
                                    );
                                  }
                                })
                          // Not ready
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    // Text(
                    //   '즐겨 찾기',
                    //   style: Theme.of(context).textTheme.headline3,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       FavoriteButton(
                    //           'WOW', Icons.access_alarm, () => print('wow')),
                    //       FavoriteButton(
                    //           'WOW', Icons.access_alarm, () => print('wow')),
                    //       FavoriteButton(
                    //           'WOW', Icons.access_alarm, () => print('wow')),
                    //     ],
                    //   ),
                    // ),
                    Text(
                      '굿푸피를 위한 훈련 가이드',
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
