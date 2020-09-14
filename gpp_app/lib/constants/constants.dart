class Strings {
  // Named constructor and set private
  Strings._();

  //General
  static const String appName = "Goodpoopee";

  // Form Error
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "Please Enter your email";
  static const String kInvalidEmailError = "Please Enter Valid Email";
  static const String kPassNullError = "Please Enter your password";
  static const String kShortPassError = "Password is too short";
  static const String kMatchPassError = "Passwords don't match";
  static const String kNicknameNullError = "Please Enter your nickname";
  static const String kPhoneNumberNullError = "Please Enter your phone number";
  static const String kAddressNullError = "Please Enter your address";
}

class Options {
  Options._();

  // Form check
  static const int passwordLength = 8;
}
