import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    Key key,
    this.text,
    this.isDense = false,
  }) : super(key: key);
  final String text;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
      ),
      width: getBlockSizeHorizontal(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.pets,
            color: AppColors.primaryColor,
            size: getBlockSizeHorizontal(15),
          ),
          SizedBox(height: getBlockSizeVertical(1)),
          Text(
            text,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: isDense
                  ? getBlockSizeHorizontal(3)
                  : getBlockSizeHorizontal(4),
            ),
          ),
        ],
      ),
    );
  }
}
