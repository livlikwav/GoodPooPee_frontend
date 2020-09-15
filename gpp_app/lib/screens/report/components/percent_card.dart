import 'package:flutter/material.dart';

Flexible percentCard(IconData iconData, String content) {
  return Flexible(
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
