import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';

class ToggleDisabled extends StatelessWidget {
  final bool _value;

  const ToggleDisabled({
    Key? key,
    required bool checked,
  })  : _value = checked,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        _value ? AppColors.grayscale50 : AppColors.grayscale20;

    final circleColor = _value ? AppColors.grayscale20 : AppColors.grayscale30;

    return Container(
      width: 50.0,
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          Positioned(
            left: _value ? 20.0 : 0.0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                border: Border.all(
                  color: backgroundColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
