import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';

import '../../routes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('기기 및 환경설정')),
      drawer: DrawerMenu(),
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
                      leading: _getColoredIcon(Icons.person_pin),
                      title: Text('회원 정보 설정'),
                      onTap: () => Navigator.of(context)
                          .pushNamed(Routes.setting_user_profile),
                    ),
                    ListTile(
                      leading: _getColoredIcon(Icons.pets),
                      title: Text('반려견 정보 설정'),
                      onTap: () => Navigator.of(context)
                          .pushNamed(Routes.setting_pet_profile),
                    ),
                    Divider(),
                    ListTile(
                      leading: _getColoredIcon(Icons.settings_cell),
                      title: Text('푸피캠/푸피스낵바 연결'),
                      onTap: () => Navigator.of(context)
                          .pushNamed(Routes.setting_device),
                    ),
                    ListTile(
                      leading: _getColoredIcon(Icons.settings_overscan),
                      title: Text('배변패드 위치 설정'),
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.setting_pad),
                    ),
                    ListTile(
                      leading: _getColoredIcon(Icons.restaurant),
                      title: Text('간식 급여 설정'),
                      onTap: () => Navigator.of(context)
                          .pushNamed(Routes.setting_feedback),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  CircleAvatar _getColoredIcon(IconData icon) {
    return CircleAvatar(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      child: Icon(icon),
    );
  }
}
