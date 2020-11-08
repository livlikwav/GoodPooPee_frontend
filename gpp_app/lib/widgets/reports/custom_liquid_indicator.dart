import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CustomLiquidIndicator extends StatefulWidget {
  CustomLiquidIndicator({
    @required this.ratio,
  });
  final double ratio;
  @override
  _CustomLiquidIndicatorState createState() => _CustomLiquidIndicatorState();
}

class _CustomLiquidIndicatorState extends State<CustomLiquidIndicator> {
  bool disabled;

  @override
  Widget build(BuildContext context) {
    widget.ratio < 0.0 ? disabled = true : disabled = false;

    return LiquidLinearProgressIndicator(
      value: widget.ratio,
      valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
      backgroundColor: AppColors.backgroundColor,
      borderColor: disabled ? AppColors.primaryColor : Colors.white,
      borderWidth: 0.0,
      borderRadius: 20.0,
      direction: Axis.vertical,
      center: disabled
          ? Icon(
              Icons.pets,
              color: Colors.grey,
            )
          : Text(
              '${(widget.ratio * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                color:
                    widget.ratio < 0.5 ? AppColors.accentColor : Colors.white,
              ),
            ),
    );
  }
}
