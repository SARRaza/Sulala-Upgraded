import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class DisabledParagraphTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final int maxLines;

  const DisabledParagraphTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.maxLines = 1, // Default to a single line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppFonts.caption2(
            color: AppColors.grayscale90,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: AppColors.grayscale10,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: AppColors.grayscale20,
              width: 1.0,
            ),
          ),
          child: TextField(
            enabled: false,
            maxLines: maxLines, // Set the maximum number of lines allowed
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppFonts.body2(
                color: AppColors.grayscale50,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: InputBorder.none,
            ),
            style: AppFonts.body2(
              color: AppColors.grayscale90,
            ),
          ),
        ),
      ],
    );
  }
}

// Example of use:
// const SizedBox(
//   width: 300,
//   child: DisabledParagraphTextField(
//     labelText: 'Enter your paragraph text',
//     hintText: 'Start typing your text here...',
//     maxLines: 5, // Adjust the number of lines you want to display
//   ),
// ),
