import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class ThreeInformationBlock extends StatelessWidget {
  final String head1;

  final String head2;

  final String head3;

  const ThreeInformationBlock({
    required this.head1,
    required this.head2,
    required this.head3,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  head1,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                Text(
                  "Type".tr,
                  style: AppFonts.caption2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
          Container(
            height: SizeConfig.heightMultiplier(context) * 22,
            width: 1,
            color: AppColors.grayscale30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  head2,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                Text(
                  "Species".tr,
                  style: AppFonts.caption2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
          Container(
            height: SizeConfig.heightMultiplier(context) * 22,
            width: 1,
            color: AppColors.grayscale30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  head3,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                Text(
                  "Sex".tr,
                  style: AppFonts.caption2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
