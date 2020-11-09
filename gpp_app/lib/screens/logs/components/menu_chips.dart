import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/screens/logs/components/photo_list.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:provider/provider.dart';

class MenuChips extends StatefulWidget {
  @override
  _MenuChipsState createState() => _MenuChipsState();
}

class _MenuChipsState extends State<MenuChips> {
  ValueNotifier<FILTER> _filter;
  List<bool> _selectionList = [true, false, false]; //default
  // final Color _selectedColor = AppColors.accentColor;
  final Color _backgroundColor = AppColors.primaryColor.withOpacity(0.5);
  final double _fontSize = getBlockSizeHorizontal(3);
  @override
  Widget build(BuildContext context) {
    _filter = Provider.of<ValueNotifier<FILTER>>(context, listen: false);
    MyLogger.debug('${_filter.value}');
    return Container(
      child: Wrap(
        children: [
          ChoiceChip(
            // selectedColor: _selectedColor,
            selectedColor: AppColors.primaryColor,
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
                _filter.value = FILTER.total;
                _selectionList = [true, false, false];
              });
            },
          ),
          SizedBox(width: getBlockSizeHorizontal(2)),
          ChoiceChip(
            // selectedColor: _selectedColor,
            selectedColor: Colors.green,
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
                _filter.value = FILTER.success;
                _selectionList = [false, true, false];
              });
            },
          ),
          SizedBox(width: getBlockSizeHorizontal(2)),
          ChoiceChip(
            // selectedColor: _selectedColor,
            selectedColor: Colors.red,
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
                _filter.value = FILTER.fail;
                _selectionList = [false, false, true];
              });
            },
          ),
        ],
      ),
    );
  }
}
