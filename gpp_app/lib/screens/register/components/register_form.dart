import 'package:dio/dio.dart' hide Options;
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/constants.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_surfix_icon.dart';
import 'package:gpp_app/widgets/default_button.dart';
import 'package:gpp_app/widgets/form_error.dart';
import 'package:gpp_app/widgets/yes_alert_dialog.dart';

import '../../../routes.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final DioClient dioClient = DioClient(Dio());
  final _formKey = GlobalKey<FormState>();
  String email;
  String firstName;
  String lastName;
  String password;
  String conformPassword;
  // bool remember = false;
  final List<String> errors = [];

  double widgetSpacer = getBlockSizeVertical(2);

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
            SizedBox(height: widgetSpacer),
            buildLastNameFormField(),
            SizedBox(height: widgetSpacer),
            buildFirstNameFormField(),
            SizedBox(height: widgetSpacer),
            buildPasswordFormField(),
            SizedBox(height: widgetSpacer),
            buildConformPassFormField(),
            SizedBox(height: widgetSpacer),
            FormError(errors: errors),
            SizedBox(height: widgetSpacer),
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

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Strings.kFirstNameNullError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: Strings.kFirstNameNullError);
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
        labelText: "이름",
        hintText: "당신의 이름을 입력하세요",
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User_Icon.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Strings.kLastNameNullError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: Strings.kLastNameNullError);
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
        labelText: "성",
        hintText: "당신의 성을 입력하세요",
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
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Strings.kPassNullError);
        }
        if (value.isNotEmpty && password == conformPassword) {
          removeError(error: Strings.kMatchPassError);
        }
        conformPassword = value;
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

  void onPressed() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Response response;
      try {
        response = await dioClient.post(
          DioClient.serverUrl + 'user/register',
          data: {
            'email': email,
            'password': password,
            'first_name': firstName,
            'last_name': lastName,
          },
        );
        MyLogger.info('Register successed');
        // =============== MUST BE DELETED AFTER FINISH LINKING REST API ===========================
        MyLogger.debug('Email: $email, Password: $password');
      } on DioError catch (e) {
        if (e.response != null) {
          MyLogger.error(
              'Register failed. Status code is ${e.response.statusCode}');
        }
      }
      // if valid, show success dialog
      if (response != null && response.statusCode == 200) {
        showYesAlertDialog(
          context,
          '회원가입이 완료되었습니다',
          () => Navigator.of(context).pushNamed(Routes.login),
        );
      }
    } else {
      MyLogger.info('Register failed(form validation failed)');
    }
  }
}
