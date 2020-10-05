import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/default_button.dart';

void showNoAlertDialog(
    BuildContext context, String title, Function press) async {
  return showDialog<void>(
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Icon(
          Icons.announcement,
          size: getBlockSizeHorizontal(20),
          color: Theme.of(context).accentColor,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('확인'),
            onPressed: press,
          ),
        ],
      );
    },
    context: context,
  );
}

// developer.log(
//   'NoAlertDialog ok button tapped',
//   name: 'DEBUG',
//   level: 10,
// );
// Navigator.of(context).pushNamed(route);
