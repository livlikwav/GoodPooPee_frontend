import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:lottie/lottie.dart';

class CheckDialog extends StatelessWidget {
  CheckDialog({this.onTapFunc});
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
                'assets/lottie/success_sign.json',
                height: getBlockSizeVertical(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
