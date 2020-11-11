import 'package:flutter/material.dart';

Flexible percentCard(
    IconData iconData, String content, Color color, Color stringColor) {
  return Flexible(
    child: Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Icon(
            iconData,
            color: stringColor,
          ),
          Text(
            content,
            style: new TextStyle(
              color: stringColor,
            ),
          ),
        ],
      ),
    ),
  );
}
