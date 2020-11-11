import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:lottie/lottie.dart';

class WarningDialog extends StatelessWidget {
  WarningDialog({this.onTapFunc});
  final Function onTapFunc;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: InkWell(
        splashColor: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTapFunc,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/alert_sign.json',
                height: getBlockSizeVertical(10),
              ),
              // Text('아이디와 비밀번호를 다시 확인해주세요'),
              // SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
