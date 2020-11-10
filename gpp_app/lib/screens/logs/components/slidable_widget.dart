import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/screens/logs/logs_provider.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:provider/provider.dart';

class SlidableWidget extends StatefulWidget {
  SlidableWidget({
    @required this.key,
    @required this.child,
    @required this.result,
    @required this.datetime,
  });
  final Key key;
  final Widget child;
  final String result;
  final DateTime datetime;
  @override
  _SlidableWidgetState createState() => _SlidableWidgetState();
}

class _SlidableWidgetState extends State<SlidableWidget> {
  LogsProvider _logsProvider;
  @override
  Widget build(BuildContext context) {
    _logsProvider = Provider.of<LogsProvider>(context, listen: false);
    MyLogger.debug('slidable widget ${widget.datetime}->${widget.result}');
    return Slidable(
      key: widget.key,
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        // SUCCESS
        IconSlideAction(
          caption: '정답',
          color: AppColors.backgroundColor,
          icon: Icons.check_circle,
          foregroundColor: Colors.green,
          onTap: () {
            if (widget.result != 'SUCCESS') {
              _logsProvider.putRecord(context, widget.datetime, 'SUCCESS');
            } else {
              MyLogger.debug('Selected same result in slidable widget');
            }
          },
        ),
        // FAIL
        IconSlideAction(
          caption: '오답',
          color: AppColors.backgroundColor,
          icon: Icons.cancel,
          foregroundColor: Colors.red,
          onTap: () {
            if (widget.result != 'FAIL') {
              _logsProvider.putRecord(context, widget.datetime, 'FAIL');
            } else {
              MyLogger.debug('Selected same result in slidable widget');
            }
          },
        ),
      ],
      child: widget.child,
    );
  }
}
