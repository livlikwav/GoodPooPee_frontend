import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void showImageDialog(BuildContext context, Uint8List image) async {
  return showDialog<void>(
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 24.0,
        content: Center(
          child: Image.memory(image),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('저장'),
            onPressed: () {
              // Save img
              // final result = await ImageGallerySaver.saveImage(image);
              // print(result);
              ImageGallerySaver.saveImage(image);
              MyLogger.info('Saving captured image succeed');
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('취소'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    context: context,
  );
}
