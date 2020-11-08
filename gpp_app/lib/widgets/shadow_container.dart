import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  ShadowContainer({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: child,
    );
  }
}
