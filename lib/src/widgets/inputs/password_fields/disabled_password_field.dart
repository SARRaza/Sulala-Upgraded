import 'package:flutter/material.dart';
import 'package:sulala_app/src/theme/colors/colors.dart';
import 'package:sulala_app/src/theme/fonts/fonts.dart';

class DisabledPasswordField extends StatelessWidget {
  final String hintText;
  final String labelText;

  const DisabledPasswordField({
    Key? key,
    required this.hintText,
    required this.labelText,
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
            obscureText: true, // Use obscureText property for password field
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
//   child: DisabledPasswordField(
//     labelText: 'Password',
//     hintText: 'Enter your password',
//   ),
// ),
