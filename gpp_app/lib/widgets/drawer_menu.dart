import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/provider/pet_profile.dart';
import 'package:gpp_app/models/provider/ppcam_profile.dart';
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
                _drawerHeader(),
                _menuItem(
                  context: context,
                  text: '홈',
                  icon: Icons.home,
                  route: Routes.home,
                ),
                _menuItem(
                  context: context,
                  text: '수업 참관하기',
                  icon: Icons.live_tv,
                  route: Routes.streaming,
                  isReplacement: false,
                ),
                _menuItem(
                  context: context,
                  text: '숙제 확인',
                  icon: Icons.history,
                  route: Routes.logs,
                ),
                _menuItem(
                  context: context,
                  text: '가정 통신문',
                  icon: Icons.list,
                  route: Routes.report,
                ),
                _menuItem(
                  context: context,
                  text: '기기 및 환경설정',
                  icon: Icons.settings,
                  route: Routes.settings,
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
              Provider.of<PpcamProfile>(context, listen: false).reset();
              // Routing
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.login, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
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
                            // style: Theme.of(context).textTheme.subtitle1,
                            style: TextStyle(
                              color: AppColors.accentColor,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _petBreed,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
      ),
    );
  }
}

Widget _menuItem({
  @required BuildContext context,
  @required String text,
  @required IconData icon,
  @required String route,
  bool isReplacement = true,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 20.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        if (isReplacement) {
          Navigator.of(context).pop(); // pop drawer menu
          Navigator.of(context).pushReplacementNamed(route);
        } else {
          Navigator.of(context).pushNamed(route);
        }
      },
      highlightColor: AppColors.primaryColor,
      splashColor: AppColors.accentColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20.0, // LEFT
                0.0,
                30.0, // RIGHT
                0.0,
              ),
              child: Icon(
                icon,
                color: AppColors.accentColor,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ListTile _menuTile({
//   @required String label,
//   @required Function onTap,
//   @required TextStyle style,
//   @required IconData leading,
// }) {
//   return ListTile(
//     leading: Icon(
//       leading,
//       color: AppColors.primaryColor,
//     ),
//     title: Text(
//       label,
//       style: style,
//     ),
//     onTap: onTap,
//   );
// }

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
