import 'package:intl/intl.dart';

String getKstWeekday(DateTime datetime) {
  final Map<String, String> kstWeekday = {
    'Mon': '월',
    'Tue': '화',
    'Wed': '수',
    'Thu': '목',
    'Fri': '금',
    'Sat': '토',
    'Sun': '일',
  };

  return kstWeekday[DateFormat('EEE').format(datetime)];
}
