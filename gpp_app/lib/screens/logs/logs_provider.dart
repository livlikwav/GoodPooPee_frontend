import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:intl/intl.dart';

class LogsProvider extends ChangeNotifier {
  BuildContext context;
  int petId;
  DateTime datetime = DateTime.now(); // default
  List<PetRecord> petRecords;
  LogsProvider(BuildContext context) {
    MyLogger.debug('LogsProvider initialized');
  }

  String get dateString {
    if (datetime == null) return null;
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(datetime);
  }
}
