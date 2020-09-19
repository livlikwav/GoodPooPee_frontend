import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/default_button.dart';

class SettingPadScreen extends StatelessWidget {
  final Color backgroundColor = AppColors.orange[100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(backgroundColor: backgroundColor, title: Text('')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildText(),
        _buildCenterImage(),
      ],
    );
  }

  Widget _buildText() {
    return Column(
      children: [
        Flexible(
          child: Container(
            width: getBlockSizeHorizontal(100), // screen width
            padding: EdgeInsets.symmetric(
              horizontal: getBlockSizeHorizontal(10),
              vertical: getBlockSizeVertical(1),
            ),
            color: backgroundColor,
            child: Column(
              children: [
                Text(
                  '배변 패드 위치 설정',
                  style: new TextStyle(
                    fontSize: getBlockSizeHorizontal(10),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getBlockSizeVertical(2),
                ),
                Text(
                  '푸피캠 화면에서\n 배변 패드의 위치를 설정해주세요!\n설정된 배변 패드의 위치로,\n푸피캠이 반려견의 배변 성공 여부를\n판단합니다.',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: getBlockSizeHorizontal(4),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: getBlockSizeHorizontal(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '화면에서 보이는\n배변 패드의 4개의 모서리를\n순서대로 터치해주세요',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: getBlockSizeHorizontal(5),
                  ),
                ),
                SizedBox(height: getBlockSizeVertical(5)),
                DefaultButton(
                  text: '다음으로',
                  press: () {
                    print('next button tapped');
                  },
                ),
                SizedBox(height: getBlockSizeVertical(7)),
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
        width: getBlockSizeHorizontal(50),
        child: Image(
          image: AssetImage(Assets.dogTrainingPad),
        ),
      ),
    );
  }
}
