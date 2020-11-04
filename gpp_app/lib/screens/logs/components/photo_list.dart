import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/screens/logs/components/photo_item.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/empty_card.dart';

class PhotoList extends StatefulWidget {
  PhotoList(this.petRecords);
  final List<PetRecord> petRecords;
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  int count;

  @override
  Widget build(BuildContext context) {
    count = widget.petRecords.length;
    MyLogger.debug('PhotoList count: $count');
    if (count > 0) {
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          MyLogger.debug(
              'Index:$index, UUID: ${widget.petRecords[index].imageUuid}');
          return PhotoItem(
            widget.petRecords[index],
          );
          // return _buildSlidable(
          //   index,
          //   context,
          //   _listItemsActive[index],
          //   widget.petRecords[index],
          // );
        },
      );
    } else {
      // There is response, but no data (error)
      return EmptyCard(text: '기록을 불러오는 중 오류가 발생했습니다.');
    }
  }
}

// Widget _buildSlidable(
//   int index,
//   BuildContext context,
//   bool isActive,
//   PetRecord petRecord,
// ) {
//   // Check success or fail
//   bool isCorrect;
//   if (petRecord.result == 'SUCCESS') {
//     isCorrect = true;
//   } else {
//     isCorrect = false;
//   }
//   return Slidable(
//     key: ValueKey(index),
//     actionPane: SlidableDrawerActionPane(),
//     secondaryActions: isActive
//         // Active
//         ? <Widget>[
//             IconSlideAction(
//               caption: '정확해요',
//               color: Colors.orangeAccent,
//               icon: Icons.check_circle,
//               foregroundColor: Colors.white,
//               onTap: () {
//                 MyLogger.debug('PhotoListItem: $index Correct tapped');
//                 setState(() {
//                   _listItemsActive[index] = false;
//                   petRecord.result = 'SUCCESS';
//                 });
//               },
//             ),
//             IconSlideAction(
//               caption: '틀렸어요',
//               color: Colors.grey,
//               icon: Icons.cancel,
//               foregroundColor: Colors.white,
//               onTap: () {
//                 MyLogger.debug('PhotoListItem: $index Incorrect tapped');
//                 setState(() {
//                   _listItemsActive[index] = false;
//                   petRecord.result = 'FAIL';
//                 });
//               },
//             ),
//           ]
//         // Inactive
//         : null,
//     child: PhotoListItem(
//       isCorrect,
//       petRecord,
//     ),
//   );
// }
