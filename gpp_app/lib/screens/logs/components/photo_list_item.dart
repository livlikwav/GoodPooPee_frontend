import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/screens/logs/components/alert_card.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoListItem extends StatefulWidget {
  PhotoListItem(this.isCorrect, this.petRecord);
  final bool isCorrect;
  final PetRecord petRecord;
  @override
  _PhotoListItemState createState() => _PhotoListItemState();
}

class _PhotoListItemState extends State<PhotoListItem> {
  String imgUrl;
  String dateString;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // init model
    imgUrl = 'https://gpp-images-1.s3.ap-northeast-2.amazonaws.com/' +
        widget.petRecord.imageUuid;
    dateString = DateFormat('HH:mm:ss').format(widget.petRecord.timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Center(child: _buildImage(imgUrl)),
            Align(
              alignment: Alignment.bottomRight,
              child: _buildStatus(widget.isCorrect),
            ),
            Align(
              // Align center based on bottomRight
              alignment: Alignment.bottomCenter,
              child: _buildText(dateString),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildImage(String imgUrl) {
  // DEBUG
  // imgUrl =
  //     'https://cdn.pixabay.com/photo/2020/05/03/13/09/puppy-5124947_1280.jpg';
  return FadeInImage.memoryNetwork(
    placeholder: kTransparentImage,
    image: imgUrl,
    imageErrorBuilder: (context, error, stackTrace) {
      // CHECK *********** : Still show exception on debug console?
      return AlertCard('이미지를 불러오는 도중 오류가 발생했습니다.');
    },
  );
}

Widget _buildStatus(bool isCorrect) {
  return isCorrect
      ? Container(
          width: getBlockSizeHorizontal(12),
          height: getBlockSizeHorizontal(12),
          margin: EdgeInsets.all(getBlockSizeVertical(3)),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
        )
      // Incorrect
      : Container(
          width: getBlockSizeHorizontal(12),
          height: getBlockSizeHorizontal(12),
          margin: EdgeInsets.all(getBlockSizeVertical(3)),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.cancel,
            color: Colors.white,
          ),
        );
}

Widget _buildText(String dateString) {
  return Container(
    // width: getBlockSizeHorizontal(12),
    // height: getBlockSizeHorizontal(12),
    margin: EdgeInsets.all(getBlockSizeVertical(1)),
    padding: EdgeInsets.all(getBlockSizeHorizontal(1)),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(dateString,
        style: new TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
  );
}
