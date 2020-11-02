import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/app_icon_widget.dart';

class AlertCard extends StatelessWidget {
  AlertCard(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
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
