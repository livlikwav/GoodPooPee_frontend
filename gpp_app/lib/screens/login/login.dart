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
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(), //empty_app_bar_widget
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: getBlockSizeVertical(90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(flex: 5, child: buildUpSide()),
            Expanded(
              flex: 3,
              child: buildCenterSide(context),
            ),
            Expanded(flex: 2, child: buildDownSide(context, registerTapped)),
          ],
        ),
      ),
    );
  }

  void registerTapped() {
    MyLogger.info('Register link tapped');
    Navigator.of(context).pushNamed(Routes.register);
  }
}
