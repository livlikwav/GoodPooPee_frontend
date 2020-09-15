import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/constants.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_surfix_icon.dart';
import 'package:gpp_app/widgets/default_button.dart';
import 'package:gpp_app/widgets/form_error.dart';
import 'package:gpp_app/widgets/yes_alert_dialog.dart';

import '../../routes.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String nickname;
  String password;
  String conform_password;
  // bool remember = false;
  final List<String> errors = [];

  double widget_spacer = getBlockSizeVertical(2);

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            buildEmailFormField(),
            SizedBox(height: widget_spacer),
            buildNicknameFormField(),
            SizedBox(height: widget_spacer),
            buildPasswordFormField(),
            SizedBox(height: widget_spacer),
            buildConformPassFormField(),
            SizedBox(height: widget_spacer),
            FormError(errors: errors),
            SizedBox(height: widget_spacer),
            DefaultButton(
              text: '확인',
              press: onPressed,
            ),
          ],
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Strings.kEmailNullError);
        }
        if (Strings.emailValidatorRegExp.hasMatch(value)) {
          removeError(error: Strings.kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: Strings.kEmailNullError);
          return "";
        }
        if (!Strings.emailValidatorRegExp.hasMatch(value)) {
          addError(error: Strings.kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          errorStyle:
              TextStyle(height: 0), // no error message under the textformfield
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(),
          border: OutlineInputBorder(),
          labelText: "이메일",
          hintText: "당신의 이메일을 입력하세요",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg")),
    );
  }

  TextFormField buildNicknameFormField() {
    return TextFormField(
      onSaved: (newValue) => nickname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Strings.kNicknameNullError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: Strings.kNicknameNullError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle:
            TextStyle(height: 0), // no error message under the textformfield
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        enabledBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
        labelText: "닉네임",
        hintText: "당신의 닉네임을 입력하세요",
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User_Icon.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Strings.kPassNullError);
        }
        if (value.length >= Options.passwordLength) {
          removeError(error: Strings.kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: Strings.kPassNullError);
          return '';
        }
        if (value.length < Options.passwordLength) {
          addError(error: Strings.kShortPassError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle:
            TextStyle(height: 0), // no error message under the textformfield
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        enabledBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
        labelText: "비밀번호",
        hintText: "계정 비밀번호를 입력하세요",
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Strings.kPassNullError);
        }
        if (value.isNotEmpty && password == conform_password) {
          removeError(error: Strings.kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: Strings.kPassNullError);
          return '';
        }
        if ((password != value)) {
          addError(error: Strings.kMatchPassError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle:
            TextStyle(height: 0), // no error message under the textformfield
        labelText: "비밀번호 확인",
        hintText: "비밀번호를 다시 입력하세요",
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        enabledBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  void onPressed() {
    developer.log(
      'register_form.dart: butten tapped',
      name: 'MY.DEBUG',
      level: 10,
    );
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // if all are valid then go to success screen
      // *****Fail to use named parameter*****
      showYesAlertDialog(context, '회원가입이 완료되었습니다.');
    }
  }
}
