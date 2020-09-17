import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:gpp_app/util/size_config.dart';

IconButton calendarIconButton() {
  return IconButton(
    icon: Icon(Icons.calendar_today),
    tooltip: '배변 기록 확인할 일자를 선택하세요.',
    color: Colors.black,
    iconSize: getBlockSizeVertical(3),
    onPressed: () {
      developer.log(
        'calendar_action icon tapped: GO TO BODY, AND CHANGE DATE',
        name: 'MY.DEBUG',
        level: 10,
      );
    },
  );
}
