import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/buttons.dart';

class SettingPadScreen extends StatefulWidget {
  @override
  _SettingPadScreenState createState() => _SettingPadScreenState();
}

class _SettingPadScreenState extends State<SettingPadScreen> {
  final Color backgroundColor = AppColors.orange[100];
  double _imgSize;
  double _paddingX;
  double _margin;
  double _fontSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(backgroundColor: backgroundColor, title: Text('')),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Orientation.portrait
              _imgSize = getBlockSizeHorizontal(50);
              _paddingX = getBlockSizeHorizontal(10);
              _margin = getBlockSizeVertical(2);
              _fontSize = getBlockSizeHorizontal(5);
              return Container(
                // width: double.infinity, // screen width
                child: Stack(
                  children: [
                    _buildText(context),
                    _buildCenterImage(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            width: double.infinity,
            color: backgroundColor,
            child: Column(
              children: [
                Text(
                  '배변 패드 위치 설정',
                  style: new TextStyle(
                    fontSize: _fontSize * 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: _margin * 2,
                ),
                Text(
                  '설정된 배변 패드의 위치로,\n푸피캠이 반려견의 배변 성공 여부를\n판단합니다.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: _fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _paddingX),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '화면에서 보이는\n배변 패드의 4개의 모서리를\n순서대로 터치해주세요',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: _fontSize,
                  ),
                ),
                SizedBox(height: _margin * 2),
                DefaultButton(
                  text: '다음으로',
                  press: () {
                    Navigator.of(context).pushNamed(Routes.setting_pad_1);
                  },
                ),
                SizedBox(height: _margin * 3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCenterImage() {
    return Center(
      child: Container(
        width: _imgSize,
        child: Image(
          image: AssetImage(Assets.dogTrainingPad),
        ),
      ),
    );
  }
}
