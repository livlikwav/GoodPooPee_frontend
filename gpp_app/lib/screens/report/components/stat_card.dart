import 'package:flutter/material.dart';
import 'package:gpp_app/constants/text_style.dart';
import 'package:gpp_app/util/size_config.dart';

Expanded statCard(String title, String content, Color color, {int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Text>[
          Text(
            title,
            style: pBoldStyle,
          ),
          Text(
            content,
            style: pStyle,
          ),
        ],
      ),
    ),
  );
}
