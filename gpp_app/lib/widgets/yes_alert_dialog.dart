import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';

void showYesAlertDialog(
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
          Icons.check,
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
