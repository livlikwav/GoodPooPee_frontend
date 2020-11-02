import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';

class DownSide extends StatelessWidget {
  DownSide(this.registerTapped);
  final Function registerTapped;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Center(
      child: RichText(
        text: TextSpan(
          style: textTheme.bodyText1,
          children: [
            TextSpan(
              text: '아직 굿푸피 계정이 없으신가요? ',
            ),
            TextSpan(
              text: '회원가입',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                fontSize: textTheme.subtitle1.fontSize,
              ),
              recognizer: TapGestureRecognizer()..onTap = registerTapped,
            ),
          ],
        ),
      ),
    );
  }
}
