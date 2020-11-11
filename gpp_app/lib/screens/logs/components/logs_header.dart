import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/screens/logs/components/menu_chips.dart';
import 'package:gpp_app/screens/logs/logs_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LogsHeader extends StatefulWidget {
  @override
  _LogsHeaderState createState() => _LogsHeaderState();
}

class _LogsHeaderState extends State<LogsHeader> {
  LogsProvider _logsProvider;

  String _formatDate(DateTime datetime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(datetime);
  }

  @override
  Widget build(BuildContext context) {
    // Init provider
    _logsProvider = Provider.of<LogsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuChips(),
        GestureDetector(
          onTap: () {
            // ShowDatePicker
            _selectDate(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.accentColor,
            ),
            // margin: const EdgeInsets.fromLTRB(0, 10.0, 20.0, 10.0),
            padding: const EdgeInsets.all(7.0),
            child: Text(
              _formatDate(_logsProvider.datetime),
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // fontSize: getBlockSizeHorizontal(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _logsProvider.datetime,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: '기록을 확인할 날짜를 선택하세요.',
      locale: Locale('ko', 'KO'),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            colorScheme: ColorScheme.light(
              primary: AppColors.accentColor,
              secondary: AppColors.accentColor,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != _logsProvider.datetime)
      _logsProvider.updateRecords(context, picked);
  }
}
