import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/screens/logs/components/logs_header.dart';
import 'package:gpp_app/screens/logs/logs_provider.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_app_bar.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:provider/provider.dart';
import 'package:rulers/rulers.dart';

import 'components/photo_list.dart';

class LogsScreen extends StatefulWidget {
  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  LogsProvider _logsProvider;

  @override
  void initState() {
    UserProfile _user = Provider.of<UserProfile>(context, listen: false);
    _logsProvider = LogsProvider(_user.petId);
    _logsProvider.initRecords(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: customAppBar(
          refreshIcon: IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
            onPressed: () {
              setState(() {
                Navigator.of(context).popAndPushNamed(Routes.logs);
              });
            },
          ),
        ),
        drawer: DrawerMenu(),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => _logsProvider),
            ChangeNotifierProvider(
              create: (context) => ValueNotifier<FILTER>(FILTER.total),
            ),
          ],
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.landscape) {
                return Center(child: CircularProgressIndicator());
              } else {
                return _buildBody(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    MyLogger.debug('LogsScreen rebuild body');
    // Get provider in context to listen change
    LogsProvider updateProvider = Provider.of<LogsProvider>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(
        0.0,
        10.0, // TOP
        30.0, // RIGHT
        0.0,
      ),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: LogsHeader(),
          ),
          updateProvider.isPetNull
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _paddingEmptyCard(
                    text: '반려견 데이터가 존재하지 않습니다.',
                  ),
                )
              : FutureBuilder(
                  future: updateProvider.petRecords,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PetRecord>> snapshot) {
                    Widget child;
                    // Future complete with data
                    if (snapshot.hasData) {
                      child = Expanded(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20.0),
                              color: Colors.grey,
                              width: getBlockSizeHorizontal(1),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                  0.0, // LEFT
                                  0.0,
                                  0.0,
                                  0.0,
                                ),
                                child: PhotoList(snapshot.data),
                              ),
                            ),
                          ],
                        ),
                      );
                      // Future complete with error
                    } else if (snapshot.hasError) {
                      DioError error = snapshot.error;
                      if (error.response != null &&
                          error.response.statusCode == 404) {
                        child = _paddingEmptyCard(
                          text: '배변 기록이 존재하지 않습니다.',
                        );
                        // Unknown error
                      } else {
                        _paddingEmptyCard(
                          text: '데이터를 불러오는 과정에서 오류가 발생하였습니다.',
                        );
                      }
                      // Future incomplete
                    } else {
                      child = Center(child: CircularProgressIndicator());
                    }
                    return child;
                  },
                ),
        ],
      ),
    );
  }
}

Widget _paddingEmptyCard({String text}) {
  text ??= 'error';
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      30.0,
      0.0,
      0.0,
      0.0,
    ),
    child: EmptyCard(
      text: text,
    ),
  );
}

Widget _staticRuler() {
  return Container(
    width: getBlockSizeHorizontal(12),
    height: double.infinity,
    child: FittedBox(
      fit: BoxFit.fill,
      child: RulerWidget(
        scaleColor: AppColors.backgroundColor,
        scaleSize: getBlockSizeHorizontal(12),
        limit: 10,
        interval: 4,
        normalBarColor: AppColors.primaryColor,
        axis: Axis.vertical,
      ),
    ),
  );
}
