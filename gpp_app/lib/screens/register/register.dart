import 'package:flutter/material.dart';
import 'package:gpp_app/constants/text_style.dart';
import 'package:gpp_app/screens/register/components/register_form.dart';
import 'package:gpp_app/util/size_config.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getBlockSizeVertical(4),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getBlockSizeVertical(3)),
              Center(
                child: Text(
                  '굿푸피 계정을 등록하세요',
                  style: h2Style,
                ),
              ),
              SizedBox(height: getBlockSizeVertical(3)),
              RegisterForm(),
              SizedBox(height: getBlockSizeVertical(3)),
              Text(
                'By creating account you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: footerStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
