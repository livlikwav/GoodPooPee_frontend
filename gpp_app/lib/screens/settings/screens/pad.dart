import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/size_config.dart';

class SettingPadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('배변패드 위치 설정')),
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(getBlockSizeHorizontal(5)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: getBlockSizeHorizontal(80),
                      height: getBlockSizeVertical(7),
                    ),
                    Text(' 개 - 발 - 중 '),
                    SizedBox(height: getBlockSizeVertical(7)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
