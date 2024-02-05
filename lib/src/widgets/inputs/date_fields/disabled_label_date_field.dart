import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class DisabledLabelDateField extends StatelessWidget {
  final String labelText;
  final String hintText;

  const DisabledLabelDateField({
    Key? key,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color hintTextColor = AppColors.grayscale50;
    const Color borderColor = AppColors.grayscale50;
    const Color backgroundColor = AppColors.grayscale20;
    const Color suffixIconColor = AppColors.primary40;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppFonts.caption2(color: AppColors.grayscale90),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: TextFormField(
                    readOnly: true, // Disable user interaction
                    style: AppFonts.body2(color: hintTextColor),
                    decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      hintStyle: AppFonts.body2(color: hintTextColor),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: suffixIconColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Example of use:

// SizedBox(
//               width: 300,
//               child: DisabledLabelDateField(
//                 labelText: 'Date of Birth',
//                 hintText: 'Select a date',
//               ),
//             ),
