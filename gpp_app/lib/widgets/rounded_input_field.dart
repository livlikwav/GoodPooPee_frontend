import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool isObscure;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: isObscure,
        style: Theme.of(context).textTheme.bodyText2,
        onChanged: onChanged,
        cursorColor: AppColors.accentColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppColors.accentColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
