import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';

class FavoriteButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function press;
  FavoriteButton(
    this.text,
    this.icon,
    this.press,
  );
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(10.0),
      color: AppColors.primaryColor.withOpacity(0.7),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
      splashColor: AppColors.primaryColor,
      onPressed: press,
      child: Column(
        children: [
          Icon(
            icon,
            // color: AppColors.accentColor,
            color: Colors.white,
            // size: getBlockSizeHorizontal(10),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        ],
      ),
    );
  }
}

class FavoritesButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function press;
  final Color color, textColor;
  const FavoritesButton({
    Key key,
    this.text,
    this.icon,
    this.press,
    this.color = AppColors.primaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Column(
            children: [
              Icon(
                icon,
                // color: AppColors.accentColor,
                color: Colors.black,
                size: getBlockSizeHorizontal(10),
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
