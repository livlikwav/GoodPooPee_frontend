import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/constants/text_style.dart';
import 'package:provider/provider.dart';

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

class DynamicButton extends StatefulWidget {
  DynamicButton({
    @required this.text,
    @required this.press,
    this.disableColor,
  });
  final String text;
  final Function press;
  final Color disableColor;
  @override
  _DynamicButtonState createState() => _DynamicButtonState();
}

class _DynamicButtonState extends State<DynamicButton> {
  @override
  Widget build(BuildContext context) {
    Color disableColor =
        widget.disableColor == null ? Colors.grey : widget.disableColor;
    ValueNotifier provider = Provider.of<ValueNotifier<bool>>(context);
    return SizedBox(
      width: double.infinity,
      height: getBlockSizeVertical(7),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).accentColor,
        onPressed: provider.value ? widget.press : null,
        disabledColor: disableColor,
        child: Text(
          widget.text,
          style: defaultButtonStyle,
        ),
      ),
    );
  }
}
