import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';

class SettingFeedbackScreen extends StatefulWidget {
  @override
  _SettingFeedbackScreenState createState() => _SettingFeedbackScreenState();
}

class _SettingFeedbackScreenState extends State<SettingFeedbackScreen> {
  // Default: On
  bool isOn = true;
  // Default : true
  bool isSliderEnabled = true;
  // Default: 100%
  double feedbackRatio = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('간식 급여 설정')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(getBlockSizeHorizontal(5)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(getBlockSizeHorizontal(5)),
                ),
                child: Column(
                  children: [
                    _feedbackAvatar(),
                    Container(
                      padding: EdgeInsets.all(getBlockSizeHorizontal(3)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _subtitle('간식 급여 설정(켜기/끄기)'),
                          _buildSwitch(),
                        ],
                      ),
                    ),
                    SizedBox(height: getBlockSizeVertical(5)),
                    Container(
                      padding: EdgeInsets.all(getBlockSizeHorizontal(3)),
                      decoration: BoxDecoration(
                        color: isSliderEnabled
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.7),
                        borderRadius:
                            BorderRadius.circular(getBlockSizeHorizontal(5)),
                      ),
                      child: Column(
                        children: [
                          _subtitle('간식 급여 확률 설정'),
                          _buildSlider(),
                          _buildIndicator(),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: getBlockSizeHorizontal(80),
                        height: getBlockSizeVertical(1)),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  CircleAvatar _feedbackAvatar() {
    return CircleAvatar(
      radius: getBlockSizeHorizontal(10),
      child: Icon(
        Icons.restaurant,
        color: Colors.orange,
        size: getBlockSizeHorizontal(10),
      ),
    );
  }

  Align _subtitle(String text) {
    return Align(
      child: Padding(
          padding: EdgeInsets.all(
            getBlockSizeHorizontal(2),
          ),
          child: Text(text)),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _buildSwitch() {
    return Switch(
      value: isOn,
      onChanged: (bool value) {
        setState(() {
          isOn = value;
          // Set Slider enable/disable
          isOn ? isSliderEnabled = true : isSliderEnabled = false;
        });
      },
    );
  }

  Widget _buildSlider() {
    return Container(
      child: Slider.adaptive(
        value: feedbackRatio,
        min: 0.0,
        max: 100.0,
        onChanged: isSliderEnabled
            ? (newValue) {
                setState(() {
                  feedbackRatio = newValue;
                });
              }
            : null,
        divisions: 4,
        // Disable in Slider.adaptive
        // label: '$feedbackRatio',
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      children: [
        Expanded(child: Center(child: Text('0%'))),
        Expanded(child: Center(child: Text('25%'))),
        Expanded(child: Center(child: Text('50%'))),
        Expanded(child: Center(child: Text('75%'))),
        Expanded(child: Center(child: Text('100%'))),
      ],
    );
  }

  // void _userDelete() {
  //   print('user delete tapped');
  // }
}
