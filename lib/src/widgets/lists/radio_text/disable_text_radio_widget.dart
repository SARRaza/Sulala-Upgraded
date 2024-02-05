import 'package:flutter/material.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class DisableTextRadioWidget extends StatefulWidget {
  final String text;
  final bool isActive;

  const DisableTextRadioWidget({
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
  State<DisableTextRadioWidget> createState() => _DisableTextRadioWidgetState();
}

class _DisableTextRadioWidgetState extends State<DisableTextRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.widthMultiplier(context) * 15,
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
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: widget.isActive
                  ? AppColors.grayscale50
                  : AppColors.grayscale20,
              border: Border.all(
                width: 1,
                color: widget.isActive
                    ? AppColors.grayscale50
                    : AppColors.grayscale30,
              ),
            ),
            child: widget.isActive
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.grayscale20,
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.grayscale20,
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(
          width: SizeConfig.widthMultiplier(context) * 15,
        ),
      ],
    );
  }
}

// Example of use:

// const DisableTextRadioWidget(
//                     isActive: false,
//                     text: 'Text Radio Widget',
//                   ),
