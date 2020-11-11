import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';

Widget alertScafold(BuildContext context, String text) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
      backgroundColor: AppColors.primaryColor,
    ),
    body: Center(
      child: Text(text),
    ),
  );
}
