import 'package:flutter/material.dart';

import 'package:sulala_app/src/data/globals.dart' as globals;

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class DisabledTextToggleWidget extends StatefulWidget {
  final String text;
  final bool isActive;

  const DisabledTextToggleWidget({
    Key? key,
    required this.text,
    required this.isActive,
  }) : super(key: key);

  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  State<DisabledTextToggleWidget> createState() =>
      _DisabledTextToggleWidgetState();
}

class _DisabledTextToggleWidgetState extends State<DisabledTextToggleWidget> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.isActive ? AppColors.grayscale50 : AppColors.grayscale20;
    final circleColor =
        widget.isActive ? AppColors.grayscale20 : AppColors.grayscale30;

    return Row(
      children: [
        SizedBox(
          width: globals.widthMediaQuery * 15,
        ),
        Text(
          widget.truncateTextWithEllipsis(widget.text, 25),
          style: AppFonts.body2(
            color: AppColors.grayscale50,
          ),
        ),
        const Spacer(), // To push the radio button to the right end of the row
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 50.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: backgroundColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: widget.isActive ? 20.0 : 0.0,
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
          ),
        ),
        SizedBox(
          width: globals.widthMediaQuery * 15,
        ),
      ],
    );
  }
}


// Example of use:

// const DisabledTextToggleWidget(
//                     text: 'Text Toggle Widget',
//                     isActive: true,
//                   ),