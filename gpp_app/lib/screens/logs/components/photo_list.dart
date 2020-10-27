import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/screens/logs/components/alert_card.dart';
import 'package:gpp_app/screens/logs/components/photo_list_item.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'dart:developer' as developer;

class PhotoList extends StatefulWidget {
  PhotoList(this.petRecords);
  final List<PetRecord> petRecords;
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  // To change listitem dynamically
  final List<bool> _listItemsActive = [];
  final List<bool> _listItemsCorrect = [];
  int count;

  @override
  void didChangeDependencies() {
    count = widget.petRecords.length;
    MyLogger.debug('PhotoList count: $count');
    super.didChangeDependencies();
  }

  void _initBoolLists() {
    for (int i = 0; i < count; i++) {
      _listItemsActive.add(true);
      _listItemsCorrect.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (count > 0) {
      _initBoolLists();
      return _buildListView();
    } else {
      // There is response, but no data (error)
      return AlertCard('기록을 불러오는 중 오류가 발생했습니다.');
    }
  }

  Widget _buildListView() {
    return ListView.builder(
      // physics: const ClampingScrollPhysics(),
      // shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return _buildSlidable(
          index,
          _listItemsActive[index],
          _listItemsCorrect[index],
          widget.petRecords[index],
        );
      },
    );
  }

  Widget _buildSlidable(
    int index,
    bool isActive,
    bool isCorrect,
    PetRecord petRecord,
  ) {
    // Check success or fail
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
                onTap: () => _setCorrect(index),
              ),
              IconSlideAction(
                caption: '틀렸어요',
                color: Colors.grey,
                icon: Icons.cancel,
                foregroundColor: Colors.white,
                onTap: () => _setIncorrect(index),
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

  void _setCorrect(int index) {
    developer.log(
      'PhotoListItem: $index Correct tapped',
      name: 'MY.DEBUG',
      level: 10,
    );
    setState(() {
      _listItemsActive[index] = false;
      _listItemsCorrect[index] = true;
    });
  }

  void _setIncorrect(int index) {
    developer.log(
      'PhotoListItem: $index Incorrect tapped',
      name: 'MY.DEBUG',
      level: 10,
    );
    setState(() {
      _listItemsActive[index] = false;
      _listItemsCorrect[index] = false;
    });
  }
}
