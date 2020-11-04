import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';

class MenuChips extends StatefulWidget {
  @override
  _MenuChipsState createState() => _MenuChipsState();
}

class _MenuChipsState extends State<MenuChips> {
  List<bool> _selectionList = [true, false, false]; //default
  final Color _selectedColor = AppColors.accentColor;
  final Color _backgroundColor = AppColors.primaryColor.withOpacity(0.5);
  final double _fontSize = getBlockSizeHorizontal(3);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          ChoiceChip(
            selectedColor: _selectedColor,
            backgroundColor: _backgroundColor,
            label: Text(
              '전체',
              style: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
              ),
            ),
            selected: _selectionList[0],
            onSelected: (bool selected) {
              setState(() {
                _selectionList = [true, false, false];
              });
            },
          ),
          SizedBox(width: getBlockSizeHorizontal(2)),
          ChoiceChip(
            selectedColor: _selectedColor,
            backgroundColor: _backgroundColor,
            label: Text(
              '성공',
              style: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
              ),
            ),
            selected: _selectionList[1],
            onSelected: (bool selected) {
              setState(() {
                _selectionList = [false, true, false];
              });
            },
          ),
          SizedBox(width: getBlockSizeHorizontal(2)),
          ChoiceChip(
            selectedColor: _selectedColor,
            backgroundColor: _backgroundColor,
            label: Text(
              '실패',
              style: TextStyle(
                color: Colors.white,
                fontSize: _fontSize,
              ),
            ),
            selected: _selectionList[2],
            onSelected: (bool selected) {
              setState(() {
                _selectionList = [false, false, true];
              });
            },
          ),
        ],
      ),
    );
  }
}
