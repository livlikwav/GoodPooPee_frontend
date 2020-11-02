import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
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
  UserProfile _userProfile;
  PetProfile _petProfile;
  String _userName;
  bool _isPetNull;
  String _petName;
  String _petBreed;

  @override
  void initState() {
    _userProfile = Provider.of<UserProfile>(context, listen: false);
    _petProfile = Provider.of<PetProfile>(context, listen: false);
    _userName = _userProfile.lastName + ' ' + _userProfile.firstName + '님';
    // check pet null
    _userProfile.petId == null ? _isPetNull = true : _isPetNull = false;
    _petName = _isPetNull ? null : _petProfile.name;
    _petBreed = _isPetNull ? null : _petProfile.breed;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _isPetNull
                  ? <Widget>[
                      Icon(
                        Icons.pets,
                        color: AppColors.accentColor,
                        size: getBlockSizeHorizontal(20),
                      ),
                      Text(
                        '반려견 프로필을 등록해주세요',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ]
                  : <Widget>[
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60.0)),
                          child: Image.asset(
                            'assets/images/yorkshire.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: _petName + ' ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            TextSpan(
                                text: _petBreed,
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                      ),
                    ],
            ),
          ),
          Container(
            child: _userInfo(_userName),
          ),
          _menuTile(context, '내 푸피캠 확인하기', route: Routes.streaming),
          _menuTile(context, '배변 기록 확인하기', route: Routes.logs),
          _menuTile(context, '배변훈련 리포트', route: Routes.report),
          _menuTile(context, '기기 및 환경설정', route: Routes.settings),
          _menuTile(
            context,
            '로그아웃',
            onTap: () {
              // Init multi providers
              Provider.of<UserProfile>(context, listen: false).reset();
              Provider.of<PetProfile>(context, listen: false).reset();
              // Routing
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.login);
            },
          ),
        ],
      ),
    );
  }
}

ListTile _menuTile(BuildContext context, String label,
    {String route, Function onTap}) {
  return ListTile(
    title: Text(
      label,
      textAlign: TextAlign.center,
    ),
    onTap: onTap ??
        () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(route);
        },
  );
}

Widget _userInfo(String name) {
  return Material(
      child: Column(
    children: <Widget>[
      SizedBox(height: getBlockSizeVertical(3)),
      Icon(Icons.portrait),
      SizedBox(height: getBlockSizeVertical(2)),
      Text(
        name,
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: getBlockSizeVertical(3)),
    ],
  ));
}

Widget _dogInfo(bool isPetNull, String name, String subtitle) {
  return Container(
    color: Colors.transparent,
    child: SingleChildScrollView(
      child: Column(
        children: isPetNull
            ? <Widget>[
                Text('반려견 정보가 없습니다',
                    style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )),
                SizedBox(height: getBlockSizeVertical(2)),
                Text(
                  '(기기 및 환경설정\n-> 반려견 정보 설정)',
                  style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]
            : <Widget>[
                Text(
                  '우리집 굿푸피',
                  style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: getBlockSizeVertical(2)),
                Text(
                  name,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: getBlockSizeVertical(1)),
                Text(
                  subtitle,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
      ),
    ),
  );
}
