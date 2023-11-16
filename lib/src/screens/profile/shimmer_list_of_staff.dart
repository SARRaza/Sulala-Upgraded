import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

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
                          height: 60 * globals.heightMediaQuery,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                20 * globals.widthMediaQuery),
                          )),
                    ),
                    SizedBox(height: 10 * globals.heightMediaQuery),
                  ],
                ),
              SizedBox(height: 14 * globals.heightMediaQuery),
              Text(
                'Requests',
                style: AppFonts.headline3(color: AppColors.grayscale80),
              ),
              SizedBox(height: 8 * globals.heightMediaQuery),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                    height: 60 * globals.heightMediaQuery,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20 * globals.widthMediaQuery),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
