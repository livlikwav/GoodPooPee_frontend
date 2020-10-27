import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/services/get_pet_records.dart';
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
  DateTime datetime = DateTime.now(); // default
  Future<List<PetRecord>> petRecords;

  String get dateString {
    if (datetime == null) return null;
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(datetime);
  }

  void initRecords(BuildContext context) {
    if (!isPetNull) {
      petRecords = getPetRecords(
        context,
        DioClient.serverUrl + 'pet/' + petId.toString() + '/records',
        dateString,
      );
    } else {
      MyLogger.debug('LogsProvider initRecords: pet is null');
    }
  }

  void updateRecords(BuildContext context, DateTime picked) {
    datetime = picked;
    petRecords = getPetRecords(
      context,
      DioClient.serverUrl + 'pet/' + petId.toString() + '/records',
      dateString,
    );
    notifyListeners();
  }
}
