class Strings {
  // Named constructor and set private
  Strings._();

  //General
  static const String appName = "Goodpoopee";

  // Form Error
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "이메일을 입력하세요";
  static const String kInvalidEmailError = "유효한 이메일을 입력하세요";
  static const String kPassNullError = "비밀번호를 입력하세요";
  static const String kShortPassError = "비밀번호는 8글자 이상으로 입력하세요";
  static const String kMatchPassError = "비밀번호가 일치하지 않습니다";
  static const String kNicknameNullError = "닉네임을 입력하세요";
  // static const String kPhoneNumberNullError = "휴대폰 번호를 입력하세요";
  // static const String kAddressNullError = "Please Enter your address";
}

class Options {
  Options._();

  // Form check
  static const int passwordLength = 8;
}
