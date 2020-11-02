import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';
// build screen
import 'components/upside.dart';
import 'components/center_side.dart';
import 'components/downside.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: EmptyAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: getBlockSizeVertical(90),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getBlockSizeHorizontal(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              UpSide(),
              CenterSide(),
              DownSide(registerTapped),
            ],
          ),
        ),
      ),
    );
  }

  void registerTapped() {
    MyLogger.info('Register link tapped');
    Navigator.of(context).pushNamed(Routes.register);
  }
}
