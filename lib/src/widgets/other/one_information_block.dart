import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';

class OneInformationBlock extends StatelessWidget {
  final String head1;

  final String subtitle1;

  const OneInformationBlock({
    required this.head1,
    required this.subtitle1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5EC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              head1,
              style: AppFonts.body2(color: AppColors.grayscale90),
            ),
            Text(
              subtitle1,
              style: AppFonts.caption2(color: AppColors.grayscale70),
            ),
          ],
        ),
      ),
    );
  }
}


// Example of use:

// InformationBlock(
//                     head1: "Head 1",
//                     head2: "Head 2",
//                   ),