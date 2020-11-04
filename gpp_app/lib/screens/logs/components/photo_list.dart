import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/screens/logs/components/photo_list_item.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:rulers/rulers.dart';

class PhotoList extends StatefulWidget {
  PhotoList(this.petRecords);
  final List<PetRecord> petRecords;
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  // To change listitem dynamically
  final List<bool> _listItemsActive = [];
  int count;

  void _initActiveLists() {
    _listItemsActive.clear();
    for (int i = 0; i < count; i++) {
      _listItemsActive.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    count = widget.petRecords.length;
    MyLogger.debug('PhotoList count: $count');
    if (count > 0) {
      _initActiveLists();
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return _buildSlidable(
            index,
            context,
            _listItemsActive[index],
            widget.petRecords[index],
          );
        },
      );
    } else {
      // There is response, but no data (error)
      return EmptyCard(text: '기록을 불러오는 중 오류가 발생했습니다.');
    }
  }

  Widget _buildSlidable(
    int index,
    BuildContext context,
    bool isActive,
    PetRecord petRecord,
  ) {
    // Check success or fail
    bool isCorrect;
    if (petRecord.result == 'SUCCESS') {
      isCorrect = true;
    } else {
      isCorrect = false;
    }
    return Slidable(
      key: ValueKey(index),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: isActive
          // Active
          ? <Widget>[
              IconSlideAction(
                caption: '정확해요',
                color: Colors.orangeAccent,
                icon: Icons.check_circle,
                foregroundColor: Colors.white,
                onTap: () {
                  MyLogger.debug('PhotoListItem: $index Correct tapped');
                  setState(() {
                    _listItemsActive[index] = false;
                    petRecord.result = 'SUCCESS';
                  });
                },
              ),
              IconSlideAction(
                caption: '틀렸어요',
                color: Colors.grey,
                icon: Icons.cancel,
                foregroundColor: Colors.white,
                onTap: () {
                  MyLogger.debug('PhotoListItem: $index Incorrect tapped');
                  setState(() {
                    _listItemsActive[index] = false;
                    petRecord.result = 'FAIL';
                  });
                },
              ),
            ]
          // Inactive
          : null,
      child: PhotoListItem(
        isCorrect,
        petRecord,
      ),
    );
  }
}
