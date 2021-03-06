import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/pad_model.dart';
import 'package:gpp_app/screens/settings/screens/pad/pad_provider.dart';
import 'package:gpp_app/services/put_pad.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/streaming/custom_vlc_controller.dart';
import 'package:provider/provider.dart';

class CustomPadMenu extends StatelessWidget {
  CustomPadMenu(this.controller, this.ppcamId);
  final CustomVlcPlayerController controller;
  final int ppcamId;
  final double _ringDiameter = 250.0;
  final double _ringWidth = 50.0;

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      // Ring rendered before orientation changed
      fabOpenIcon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      ringDiameter: _ringDiameter,
      ringWidth: _ringWidth,
      fabOpenColor: Colors.white,
      fabColor: AppColors.primaryColor,
      ringColor: AppColors.primaryColor,
      children: <Widget>[
        _backMenu(context),
        _resetMenu(context),
        _checkMenu(context),
      ],
    );
  }

  IconButton _checkMenu(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.check),
      onPressed: () {
        // PUT PAD
        List<double> _reqList =
            Provider.of<PadProvider>(context, listen: false).getPadResult();
        PadModel _padModel = PadModel.byList(_reqList);
        putPad(context, _padModel);
      },
    );
  }

  IconButton _resetMenu(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.loop),
      onPressed: () {
        Provider.of<PadProvider>(context, listen: false).resetPosList();
      },
    );
  }

  IconButton _backMenu(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        MyLogger.info('Exit button tapped');
        Navigator.of(context).pop();
      },
    );
  }
}
