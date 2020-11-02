import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/screens/logs/components/logs_header.dart';
import 'package:gpp_app/screens/logs/logs_provider.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:provider/provider.dart';

import 'components/alert_card.dart';
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
        appBar: AppBar(
          title: Text('배변 기록 확인하기'),
        ),
        drawer: DrawerMenu(),
        body: ChangeNotifierProvider(
          create: (context) => _logsProvider,
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
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          LogsHeader(),
          updateProvider.isPetNull
              ? AlertCard(
                  '반려견 데이터가 존재하지 않습니다.',
                )
              : FutureBuilder(
                  future: updateProvider.petRecords,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PetRecord>> snapshot) {
                    Widget child;
                    // Future complete with data
                    if (snapshot.hasData) {
                      child = Expanded(
                        child: PhotoList(snapshot.data),
                      );
                      // Future complete with error
                    } else if (snapshot.hasError) {
                      DioError error = snapshot.error;
                      if (error.response != null &&
                          error.response.statusCode == 404) {
                        child = AlertCard(
                          '오늘의 배변 기록이 존재하지 않습니다.',
                        );
                        // Unknown error
                      } else {
                        child = AlertCard(
                          '데이터를 불러오는 과정에서 오류가 발생하였습니다.',
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
