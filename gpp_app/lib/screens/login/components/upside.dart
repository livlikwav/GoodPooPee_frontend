import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:lottie/lottie.dart';

class UpSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: textTheme.headline2,
              children: <TextSpan>[
                TextSpan(
                  text: '굿퍼피의 시작은,\n',
                ),
                TextSpan(
                  text: '굿푸피',
                  style: TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '로부터.',
                ),
              ],
            ),
          ),
        ),
        Lottie.asset(
          'assets/lottie/gpp_login.json',
          width: getBlockSizeHorizontal(60),
        ),
      ],
    );
  }
}
