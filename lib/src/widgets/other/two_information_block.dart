import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class TwoInformationBlock extends StatelessWidget {
  final String head1;
  final String head2;
  final String subtitle1;
  final String subtitle2;
  final void Function()? onTap1;
  final void Function()? onTap2;

  const TwoInformationBlock({
    required this.head1,
    required this.head2,
    required this.subtitle1,
    required this.subtitle2,
    this.onTap1,
    this.onTap2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5EC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onTap1,
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
          ),
          Container(
            height: globals.heightMediaQuery * 22,
            width: 1,
            color: AppColors.grayscale30,
          ),
          GestureDetector(
            onTap: onTap2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    head2,
                    style: AppFonts.body2(color: AppColors.grayscale90),
                  ),
                  Text(
                    subtitle2,
                    style: AppFonts.caption2(color: AppColors.grayscale70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Example of use:

// InformationBlock(
//                     head1: "Head 1",
//                     head2: "Head 2",
//                   ),