import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/screens/settings/screens/pad/pad_provider.dart';
import 'package:provider/provider.dart';

class CustomSnackbar extends StatelessWidget {
  final List<String> strList = [
    '왼쪽-위 점을 선택해주세요',
    '왼쪽-아래 점을 선택해주세요',
    '오른쪽-아래 점을 선택해주세요',
    '오른쪽-위 점을 선택해주세요',
    '완료되었습니다',
  ];
  final double _padding = 10.0;
  final double _margin = 10.0;

  @override
  Widget build(BuildContext context) {
    int length = Provider.of<PadProvider>(context).widgetList.length;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: _margin),
        padding: EdgeInsets.all(_padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AppColors.primaryColor.withOpacity(0.7),
        ),
        child: Text(
          strList[length],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
