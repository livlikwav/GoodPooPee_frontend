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
          _menuTile(
            label: '홈',
            style: Theme.of(context).textTheme.bodyText2,
            leading: Icons.home,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.report);
            },
          ),
          _menuTile(
            label: '내 푸피캠 확인하기',
            style: Theme.of(context).textTheme.bodyText2,
            leading: Icons.live_tv,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.streaming);
            },
          ),
          _menuTile(
            label: '배변 기록 확인하기',
            leading: Icons.history,
            style: Theme.of(context).textTheme.bodyText2,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.logs);
            },
          ),
          _menuTile(
            label: '배변 훈련 리포트',
            leading: Icons.list,
            style: Theme.of(context).textTheme.bodyText2,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.report);
            },
          ),
          _menuTile(
            label: '기기 및 환경설정',
            leading: Icons.settings,
            style: Theme.of(context).textTheme.bodyText2,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.settings);
            },
          ),
          Divider(),
          _menuTile(
            label: '로그아웃',
            leading: Icons.exit_to_app,
            style: Theme.of(context).textTheme.bodyText2,
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
