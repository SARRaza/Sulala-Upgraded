import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';

class ShimmerListOfStaff extends StatelessWidget {
  const ShimmerListOfStaff({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 5; i++)
                Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                          height: 60 * SizeConfig.heightMultiplier(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                20 * SizeConfig.widthMultiplier(context)),
                          )),
                    ),
                    SizedBox(height: 10 * SizeConfig.heightMultiplier(context)),
                  ],
                ),
              SizedBox(height: 14 * SizeConfig.heightMultiplier(context)),
              Text(
                'Requests'.tr,
                style: AppFonts.headline3(color: AppColors.grayscale80),
              ),
              SizedBox(height: 8 * SizeConfig.heightMultiplier(context)),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                    height: 60 * SizeConfig.heightMultiplier(context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          20 * SizeConfig.widthMultiplier(context)),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
