import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/screens/logs/components/slidable_widget.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoItem extends StatefulWidget {
  PhotoItem({
    @required this.petRecord,
    @required this.key,
  });
  final PetRecord petRecord;
  final Key key;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              children: [
                _indicatorBar(),
                _timeText(),
              ],
            ),
          ),
          Expanded(
              child: _photoWidget(
            key: widget.key,
            datetime: widget.petRecord.timestamp,
            result: widget.petRecord.result,
          )),
        ],
      ),
    );
  }

  Widget _timeText() {
    return Text(
      '$dateString',
      style: TextStyle(
        color: Colors.black,
        // color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container _indicatorBar() {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        // color: Colors.grey,
        color: AppColors.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(100)),
      ),
      width: getBlockSizeHorizontal(5),
      height: getBlockSizeVertical(0.5),
    );
  }

  Widget _photoWidget({Key key, DateTime datetime, String result}) {
    return SlidableWidget(
      key: key,
      datetime: datetime,
      result: result,
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
    );
  }
}

Widget getStatus(String result) {
  double _size = getBlockSizeHorizontal(7);
  Widget child;
  if (result == 'SUCCESS') {
    child = Icon(
      Icons.check_circle,
      color: Colors.green,
      size: _size,
    );
  } else if (result == 'FAIL') {
    child = Icon(
      Icons.cancel,
      color: Colors.red,
      size: _size,
    );
  } else {
    child = Icon(
      Icons.error,
      color: Colors.grey,
      size: _size,
    );
  }
  // return child;
  return Container(
    width: getBlockSizeHorizontal(7),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Center(child: child),
  );
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
