import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/app_icon_widget.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    Key key,
    this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
      ),
      width: getBlockSizeHorizontal(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(text),
          SizedBox(
            height: getBlockSizeVertical(3),
          ),
          AppIconWidget(image: Assets.appLogo),
        ],
      ),
    );
  }
}
