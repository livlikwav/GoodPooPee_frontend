import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/provider/pet_profile.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  PetProfile _petProfile;
  bool _isPetNull;
  String _petName;
  String _petBreed;

  @override
  void initState() {
    _petProfile = Provider.of<PetProfile>(context, listen: false);
    // check pet null
    if (_petProfile == null) {
      throw Exception('Pet Provider is not initialized in login screen.');
    } else {
      _petProfile.id == null ? _isPetNull = true : _isPetNull = false;
      if (_isPetNull) {
        _petName = null;
        _petBreed = null;
      } else {
        _petName = _petProfile.name;
        _petBreed = _petProfile.breed;
      }
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _isPetNull
                        ? <Widget>[
                            Icon(
                              Icons.pets,
                              // color: AppColors.accentColor,
                              color: Colors.black.withOpacity(0.5),
                              size: getBlockSizeHorizontal(20),
                            ),
                            Text(
                              '반려견 프로필을 등록해주세요',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ]
                        : <Widget>[
                            Row(
                              // alignment: Alignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.6),
                                          offset: const Offset(2.0, 4.0),
                                          blurRadius: 8),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(60.0)),
                                    child: Image.asset(
                                      'assets/images/spitz.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // SizedBox(width: getBlockSizeHorizontal(5)),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _petName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      Text(
                                        _petBreed,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                  ),
                ),
                _menuTile(
                  label: '홈',
                  style: Theme.of(context).textTheme.bodyText2,
                  leading: Icons.home,
                  onTap: () {
                    Navigator.pop(context); // pop drawer
                    Navigator.of(context).pushReplacementNamed(Routes.home);
                  },
                ),
                _menuTile(
                  label: '내 푸피캠 확인하기',
                  style: Theme.of(context).textTheme.bodyText2,
                  leading: Icons.live_tv,
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(Routes.streaming);
                  },
                ),
                _menuTile(
                  label: '배변 기록 확인하기',
                  leading: Icons.history,
                  style: Theme.of(context).textTheme.bodyText2,
                  onTap: () {
                    Navigator.pop(context); // pop drawer
                    Navigator.of(context).pushReplacementNamed(Routes.logs);
                  },
                ),
                _menuTile(
                  label: '배변 훈련 리포트',
                  leading: Icons.list,
                  style: Theme.of(context).textTheme.bodyText2,
                  onTap: () {
                    Navigator.pop(context); // pop drawer
                    Navigator.of(context).pushReplacementNamed(Routes.report);
                  },
                ),
                _menuTile(
                  label: '기기 및 환경설정',
                  leading: Icons.settings,
                  style: Theme.of(context).textTheme.bodyText2,
                  onTap: () {
                    Navigator.pop(context); // pop drawer
                    Navigator.of(context).pushReplacementNamed(Routes.settings);
                  },
                ),
              ],
            ),
          ),
          Divider(),
          _logoutTile(
            label: '로그아웃',
            style: Theme.of(context).textTheme.bodyText2,
            onTap: () {
              // Init multi providers
              Provider.of<UserProfile>(context, listen: false).reset();
              Provider.of<PetProfile>(context, listen: false).reset();
              // Routing
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.login, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}

ListTile _menuTile({
  @required String label,
  @required Function onTap,
  @required TextStyle style,
  @required IconData leading,
}) {
  return ListTile(
    leading: Icon(leading),
    title: Text(
      label,
      style: style,
    ),
    onTap: onTap,
  );
}

ListTile _logoutTile({
  @required String label,
  @required Function onTap,
  @required TextStyle style,
}) {
  return ListTile(
    trailing: Icon(Icons.power_settings_new),
    title: Text(
      label,
      style: style,
    ),
    onTap: onTap,
  );
}
