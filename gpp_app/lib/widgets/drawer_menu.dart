import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/size_config.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: _dogProfile()),
          Container(
            child: _userProfile(),
          ),
          _menuTile(context, '내 푸피캠 확인하기', Routes.streaming),
          _divider(),
          _menuTile(context, '배변 기록 확인하기', Routes.logs),
          _menuTile(context, '배변훈련 리포트', Routes.report),
          _divider(),
          _menuTile(context, '기기 및 환경설정', Routes.settings),
          _menuTile(context, '로그아웃', Routes.login),
        ],
      ),
    );
  }
}

ListTile _menuTile(BuildContext context, String label, String route) {
  return ListTile(
    title: Text(
      label,
      textAlign: TextAlign.center,
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(route);
    },
  );
}

Divider _divider() {
  return Divider(
    color: Colors.black,
    indent: getBlockSizeHorizontal(10),
    endIndent: getBlockSizeHorizontal(10),
  );
}

Widget _userProfile() {
  return Material(
      child: Column(
    children: <Widget>[
      SizedBox(height: getBlockSizeVertical(3)),
      CircleAvatar(
        backgroundImage: new AssetImage(Assets.appLogo),
      ),
      SizedBox(height: getBlockSizeVertical(2)),
      Text('User Nickname', style: new TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: getBlockSizeVertical(3)),
    ],
  ));
}

Widget _dogProfile() {
  return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('우리집 굿푸피',
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: getBlockSizeVertical(2)),
            CircleAvatar(
              backgroundImage: new AssetImage(Assets.dogProfile),
            ),
            SizedBox(height: getBlockSizeVertical(2)),
            Text('포동이',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            SizedBox(height: getBlockSizeVertical(1)),
            Text('요크셔테리어, 수컷, 7살',
                style: new TextStyle(
                  color: Colors.white,
                )),
          ],
        ),
      ));
}
