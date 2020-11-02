import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UpSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('굿퍼피의 시작은 굿푸피로부터'),
        Lottie.asset('assets/lottie/login.json'),
        Text('로그인'),
      ],
    );
  }
}
