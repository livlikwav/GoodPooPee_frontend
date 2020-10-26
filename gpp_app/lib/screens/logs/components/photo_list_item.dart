import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';

ListTile photoListItem(bool isVisible, bool isCorrect) {
  return ListTile(
    title: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _buildImage(),
          _buildStatus(isVisible, isCorrect),
          Align(
            // Align center based on bottomRight
            alignment: Alignment.topLeft,
            child: _buildTime(),
          ),
        ],
      ),
    ),
  );
}

Widget _buildImage() {
  return Image.network(
      'https://cdn.pixabay.com/photo/2020/05/03/13/09/puppy-5124947_1280.jpg');
}

Widget _buildStatus(bool isVisible, bool isCorrect) {
  return Visibility(
    visible: isVisible,
    child: isCorrect
        // Correct
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
          ),
  );
}

Widget _buildTime() {
  return Container(
    // width: getBlockSizeHorizontal(12),
    // height: getBlockSizeHorizontal(12),
    margin: EdgeInsets.all(getBlockSizeVertical(1)),
    padding: EdgeInsets.all(getBlockSizeHorizontal(1)),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text('24:60:60',
        style: new TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
  );
}
