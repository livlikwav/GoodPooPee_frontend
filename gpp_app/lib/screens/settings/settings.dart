import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_app_bar.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';

import '../../routes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: customAppBar(),
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
    final TextStyle _textStyle = Theme.of(context).textTheme.bodyText1;
    return Container(
      color: AppColors.backgroundColor,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(getBlockSizeHorizontal(5)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(getBlockSizeVertical(2)),
              children: <Widget>[
                ListTile(
                  trailing: _getColoredIcon(Icons.person_pin),
                  title: Text(
                    '회원 정보 설정',
                    style: _textStyle,
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed(Routes.setting_user_profile),
                ),
                Divider(),
                ListTile(
                  trailing: _getColoredIcon(Icons.pets),
                  title: Text(
                    '반려견 정보 설정',
                    style: _textStyle,
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed(Routes.setting_pet_profile),
                ),
                Divider(),
                ListTile(
                  trailing: _getColoredIcon(Icons.settings_cell),
                  title: Text(
                    '푸피캠/푸피스낵바 연결',
                    style: _textStyle,
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.setting_device),
                ),
                Divider(),
                ListTile(
                  trailing: _getColoredIcon(Icons.settings_overscan),
                  title: Text(
                    '배변패드 위치 설정',
                    style: _textStyle,
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.setting_pad),
                ),
                Divider(),
                ListTile(
                  trailing: _getColoredIcon(Icons.restaurant),
                  title: Text(
                    '간식 급여 설정',
                    style: _textStyle,
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.setting_feedback),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CircleAvatar _getColoredIcon(IconData icon) {
    return CircleAvatar(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: AppColors.accentColor,
      child: Icon(icon),
    );
  }
}
