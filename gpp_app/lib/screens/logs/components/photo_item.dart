import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoItem extends StatefulWidget {
  PhotoItem(this.petRecord);
  final PetRecord petRecord;
  @override
  _PhotoItemState createState() => _PhotoItemState();
}

class _PhotoItemState extends State<PhotoItem> {
  String imgUrl;
  String dateString;
  bool isImageSucceed = true;

  @override
  Widget build(BuildContext context) {
    // init model
    imgUrl = 'https://gpp-images-1.s3.ap-northeast-2.amazonaws.com/' +
        widget.petRecord.imageUuid;
    dateString = DateFormat('HH:mm:ss').format(widget.petRecord.timestamp);
    return Container(
      child: Row(
        children: [
          Text(
            '$dateString',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                5.0, // LEFT
                10.0, // TOP
                0.0,
                10.0, // BOTTOM
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: imgUrl,
                      imageErrorBuilder: (context, error, stackTrace) {
                        // show exception in debug console
                        return EmptyCard(
                          text: '이미지를 불러오는 도중 오류가 발생했습니다.',
                          isDense: true,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: getStatus(widget.petRecord.result),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getStatus(String result) {
  double _size = getBlockSizeHorizontal(7);
  if (result == 'SUCCESS') {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: _size,
    );
  } else if (result == 'FAIL') {
    return Icon(
      Icons.cancel,
      color: Colors.red,
      size: _size,
    );
  } else {
    return Icon(
      Icons.error,
      color: Colors.grey,
      size: _size,
    );
  }
}

Widget getPhotoItem(PetRecord petRecord) {
  String imgUrl = 'https://gpp-images-1.s3.ap-northeast-2.amazonaws.com/' +
      petRecord.imageUuid;
  // String dateString = DateFormat('HH:mm:ss').format(petRecord.timestamp);
  return Container(
    child: FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: imgUrl,
      imageErrorBuilder: (context, error, stackTrace) {
        // show exception in debug console
        return EmptyCard(
          text: '이미지를 불러오는 도중 오류가 발생했습니다.',
          isDense: true,
        );
      },
    ),
  );
}