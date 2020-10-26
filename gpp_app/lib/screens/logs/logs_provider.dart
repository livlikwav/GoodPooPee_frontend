import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:intl/intl.dart';

class LogsProvider extends ChangeNotifier {
  LogsProvider(int petId) {
    this.petId = petId;
    petId == null ? isPetNull = true : isPetNull = false;
    MyLogger.debug('LogsProvider initialized: petID $petId, $datetime');
  }
  int petId;
  bool isPetNull;
  // DateTime datetime = DateTime.now(); // default
  DateTime datetime = DateTime(2020, 10, 18); // default
  Future<List<PetRecord>> petRecords;

  String get dateString {
    if (datetime == null) return null;
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(datetime);
  }
}
