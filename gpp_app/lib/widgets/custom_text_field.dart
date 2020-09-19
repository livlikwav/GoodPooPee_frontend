import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';

Widget customTextField(String label, String hint,
    {bool obscure: false, bool isEnabled: true}) {
  return Container(
      width: double.infinity,
      height: getBlockSizeVertical(7),
      child: TextField(
        obscureText: obscure,
        enabled: isEnabled,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(),
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hint,
        ),
      ));
}
