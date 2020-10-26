import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/screens/logs/components/logs_header.dart';
import 'package:gpp_app/screens/logs/logs_provider.dart';
import 'package:gpp_app/services/get_pet_records.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:provider/provider.dart';

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
    if (!_logsProvider.isPetNull) {
      _logsProvider.petRecords = getPetRecords(
        context,
        DioClient.serverUrl +
            'pet/' +
            _logsProvider.petId.toString() +
            '/records',
        _logsProvider.dateString,
      );
    }
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
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          LogsHeader(),
          _logsProvider.isPetNull
              ? EmptyCard(
                  text: '반려견 데이터가 존재하지 않습니다.',
                )
              : FutureBuilder(
                  future: _logsProvider.petRecords,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PetRecord>> snapshot) {
                    Widget child;
                    // Future complete with data
                    if (snapshot.hasData) {
                      child = Expanded(
                        child: PhotoList(),
                      );
                      // Future complete with error
                    } else if (snapshot.hasError) {
                      DioError error = snapshot.error;
                      if (error.response != null &&
                          error.response.statusCode == 404) {
                        child = EmptyCard(
                          text: '오늘의 배변 기록이 존재하지 않습니다.',
                        );
                        // Unknown error
                      } else {
                        child = EmptyCard(
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
