import 'package:flutter/material.dart';
import 'package:gpp_app/screens/logs/components/logs_header.dart';
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
      // height: MediaQuery.of(context).size.height,
      // padding: const EdgeInsets.all(5),
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          LogsHeader(),
          Expanded(
            child: PhotoList(),
          ),
        ],
      ),
    );
  }
}
