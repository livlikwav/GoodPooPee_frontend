import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';

class WaitingCard extends StatelessWidget {
  const WaitingCard({
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
          Text(
            text,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: getBlockSizeVertical(3),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
