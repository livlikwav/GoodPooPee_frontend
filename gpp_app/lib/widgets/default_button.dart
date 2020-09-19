import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/constants/text_style.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getBlockSizeVertical(7),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).accentColor,
        onPressed: press,
        child: Text(
          text,
          style: defaultButtonStyle,
        ),
      ),
    );
  }
}
