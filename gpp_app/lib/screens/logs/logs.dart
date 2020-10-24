import 'package:flutter/material.dart';
import 'package:gpp_app/screens/logs/components/logs_header.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';

import 'components/photo_list.dart';

class LogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text('배변 기록 확인하기'),
        ),
        drawer: DrawerMenu(),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _buildBody(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            0,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              getBlockSizeHorizontal(3),
              getBlockSizeHorizontal(3),
              getBlockSizeHorizontal(3),
              getBlockSizeHorizontal(3),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  LogsHeader(),
                  SizedBox(height: getBlockSizeVertical(2)),
                  PhotoList(),
                ],
              ),
            ),
          )),
    );
  }
}
