import 'package:flutter/material.dart';
import 'package:sulala_app/src/theme/colors/colors.dart';
import 'package:sulala_app/src/theme/fonts/fonts.dart';

class DisabledPrimaryTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;

  const DisabledPrimaryTextField({
    Key? key,
    required this.hintText,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Column(
            children: [
              Text(
                labelText!,
                style: AppFonts.caption2(
                  color: AppColors.grayscale90,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
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

// DisabledPrimaryTextField(
//   hintText: 'Enter your text',
// )
