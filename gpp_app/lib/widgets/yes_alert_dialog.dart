import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/default_button.dart';

import '../routes.dart';

void showYesAlertDialog(
    BuildContext context, String route, String title) async {
  return showDialog<void>(
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(title)),
        content: Icon(
          Icons.check,
          size: getBlockSizeHorizontal(20),
          color: Theme.of(context).accentColor,
        ),
        actions: <Widget>[
          Container(
            width: getBlockSizeHorizontal(70),
            child: DefaultButton(
                text: '확인',
                press: () {
                  developer.log(
                    'register_form.dart: route to login',
                    name: 'MY.DEBUG',
                    level: 10,
                  );
                  Navigator.of(context).pushNamed(route);
                }),
          )
        ],
      );
    },
    context: context,
  );
}
