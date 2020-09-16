import 'package:flutter/material.dart';
import 'package:gpp_app/constants/text_style.dart';
import 'package:gpp_app/screens/logs/components/calendar_icon_button.dart';
import 'package:gpp_app/util/size_config.dart';

class LogsHeader extends StatefulWidget {
  @override
  _LogsHeaderState createState() => _LogsHeaderState();
}

class _LogsHeaderState extends State<LogsHeader> {
  String date = 'YYYY-MM-DD';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getBlockSizeHorizontal(70),
      height: getBlockSizeVertical(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '${date}',
              textAlign: TextAlign.center,
              style: defaultButtonStyle,
            ),
          ),
          Expanded(
            flex: 1,
            child: calendarIconButton(),
          ),
        ],
      ),
    );
  }
}
