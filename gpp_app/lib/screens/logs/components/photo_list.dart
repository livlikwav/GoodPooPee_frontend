import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gpp_app/screens/logs/components/photo_list_item.dart';
import 'package:gpp_app/util/size_config.dart';
import 'dart:developer' as developer;

import 'package:gpp_app/widgets/empty_card.dart';

class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  // To change listitem dynamically
  final List<bool> _listItemsActive = [];
  final List<bool> _listItemsVisible = [];
  final List<bool> _listItemsCorrect = [];
  // For DEV, later initialized by REST API
  int itemCount = 7;

  void _initBoolLists() {
    for (int i = 0; i < itemCount; i++) {
      _listItemsActive.add(true);
      _listItemsVisible.add(false);
      _listItemsCorrect.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (itemCount > 0) {
      _initBoolLists();
      return _buildListView();
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        width: getBlockSizeHorizontal(90),
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(15.0),
        child: EmptyCard(
          text: '해당 일자의 배변 기록이 존재하지 않습니다.',
        ),
      );
    }
  }

  Widget _buildListView() {
    return ListView.builder(
      // physics: const ClampingScrollPhysics(),
      // shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return _buildSlidable(
          index,
          _listItemsActive[index],
          _listItemsVisible[index],
          _listItemsCorrect[index],
        );
      },
    );
  }

  Widget _buildSlidable(
    int index,
    bool isActive,
    bool isVisible,
    bool isCorrect,
  ) {
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
      child: photoListItem(
        isVisible,
        isCorrect,
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
      _listItemsVisible[index] = true;
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
      _listItemsVisible[index] = true;
      _listItemsCorrect[index] = false;
    });
  }
}
