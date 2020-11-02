import 'package:flutter/material.dart';
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
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getBlockSizeHorizontal(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getBlockSizeVertical(3)),
                  Center(
                    child: Text(
                      '굿푸피 계정을 등록하세요',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: getBlockSizeVertical(3)),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
