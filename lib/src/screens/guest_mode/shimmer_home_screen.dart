import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../theme/colors/colors.dart';

class ShimmerHomePageWidget extends StatelessWidget {
  const ShimmerHomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: SizeConfig.heightMultiplier(context) * 211,
                  decoration: BoxDecoration(
                    color: AppColors.grayscale10,
                    borderRadius: BorderRadius.circular(
                        SizeConfig.widthMultiplier(context) * 19),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        (SizeConfig.widthMultiplier(context) * 18)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: SizeConfig.widthMultiplier(context) * 49,
                            height: SizeConfig.heightMultiplier(context) * 49,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.widthMultiplier(context) * 188),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: SizeConfig.heightMultiplier(context) * 14),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: SizeConfig.heightMultiplier(context) * 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.widthMultiplier(context) * 24),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: SizeConfig.heightMultiplier(context) * 14),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: SizeConfig.heightMultiplier(context) * 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.widthMultiplier(context) * 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(width: SizeConfig.widthMultiplier(context) * 13),
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: SizeConfig.heightMultiplier(context) * 211,
                  decoration: BoxDecoration(
                    color: AppColors.grayscale10,
                    borderRadius: BorderRadius.circular(
                        SizeConfig.widthMultiplier(context) * 19),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        SizeConfig.widthMultiplier(context) * 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: SizeConfig.widthMultiplier(context) * 49,
                            height: SizeConfig.heightMultiplier(context) * 49,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.widthMultiplier(context) * 188),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 14,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: SizeConfig.heightMultiplier(context) * 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.widthMultiplier(context) * 24),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 14,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: SizeConfig.heightMultiplier(context) * 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.widthMultiplier(context) * 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.heightMultiplier(context) * 110),
        SizedBox(
          width: SizeConfig.widthMultiplier(context) * 312,
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: SizeConfig.heightMultiplier(context) * 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        SizeConfig.widthMultiplier(context) * 20),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                    height: SizeConfig.heightMultiplier(context) * 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.widthMultiplier(context) * 20),
                    )),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 9),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                    height: SizeConfig.heightMultiplier(context) * 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.widthMultiplier(context) * 20),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
