import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';

Expanded statCard(String title, String content, Color color,
    {int flex = 1, bool titleLogo = false}) {
  final double shadowWidth = 1.0;
  final double shaodwHeight = 1.0;

  return Expanded(
    flex: flex,
    child: Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            offset: new Offset(shadowWidth, shaodwHeight),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Text>[
                Text(
                  title,
                ),
                Text(
                  content,
                ),
              ],
            ),
          ),
          titleLogo
              ? CircleAvatar(
                  backgroundImage: new AssetImage(Assets.appLogo),
                )
              : SizedBox(
                  width: 0,
                ),
        ],
      ),
    ),
  );
}
