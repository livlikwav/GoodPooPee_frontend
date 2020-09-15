import 'package:flutter/material.dart';

Flexible percentCard(IconData iconData, String content, Color color) {
  return Flexible(
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Icon(iconData),
          Text(content),
        ],
      ),
    ),
  );
}
