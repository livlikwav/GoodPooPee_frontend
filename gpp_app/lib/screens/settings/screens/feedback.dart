import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/size_config.dart';

class SettingFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('간식 급여 설정')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(getBlockSizeHorizontal(5)),
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(getBlockSizeVertical(3)),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.portrait),
                      title: Text('회원 정보 설정'),
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.report),
                    ),
                    ListTile(
                      leading: Icon(Icons.portrait),
                      title: Text('반려견 정보 설정'),
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.report),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.wifi),
                      title: Text('푸피캠/푸피스낵바 연결'),
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.report),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('배변패드 위치 설정'),
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.report),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('간식 급여 설정'),
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.report),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
