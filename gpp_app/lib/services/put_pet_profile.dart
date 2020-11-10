import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/pet_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/check_dialog.dart';

void putPetProfile(
  BuildContext context,
  PetModel petModel,
) async {
  final Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  // host/pet/<int:pet_id> PUT
  try {
    response = await dioClient.put(
      DioClient.serverUrl + 'pet/' + petModel.id.toString(),
      data: {
        'user_id': petModel.userId,
        'name': petModel.name,
        'breed': petModel.breed,
        'gender': petModel.genderStr,
        'birth': petModel.birth.toString(),
        'adoption': petModel.adoption.toString(),
      },
      interceptor: UserAuthInterceptor(context, _dio),
    );
    // Handling exception
  } on DioError {
    MyLogger.error('PUT pet profile failed by error');
    return;
  }
  // PUT Successed
  MyLogger.debug('response data : ${response.data}');
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return CheckDialog(
        onTapFunc: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    },
  );
}
