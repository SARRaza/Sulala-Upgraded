import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import 'list_of_staff.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class ShimmerProfilePage extends StatelessWidget {
  const ShimmerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 40 * SizeConfig.heightMultiplier(context)),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 120 * SizeConfig.heightMultiplier(context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                )),
          ),
          SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 28 * SizeConfig.heightMultiplier(context),
                width: 160 * SizeConfig.widthMultiplier(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      20 * SizeConfig.widthMultiplier(context)),
                )),
          ),
          SizedBox(height: 4 * SizeConfig.heightMultiplier(context)),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 18 * SizeConfig.heightMultiplier(context),
                width: 160 * SizeConfig.widthMultiplier(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      20 * SizeConfig.widthMultiplier(context)),
                )),
          ),
          SizedBox(height: 4 * SizeConfig.heightMultiplier(context)),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 18 * SizeConfig.heightMultiplier(context),
                width: 160 * SizeConfig.widthMultiplier(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      20 * SizeConfig.widthMultiplier(context)),
                )),
          ),
          SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 20 * SizeConfig.heightMultiplier(context),
                width: 160 * SizeConfig.widthMultiplier(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      20 * SizeConfig.widthMultiplier(context)),
                )),
          ),
          SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
          SizedBox(
            height: 40 * SizeConfig.heightMultiplier(context),
            width: 343 * SizeConfig.widthMultiplier(context),
            child: PrimaryButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListOfStaff()),
                );
                // Add function of the button below
              },
              text: 'Collaboration',
              position: PrimaryButtonPosition.right,
            ),
          ),
          SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
          Container(
            height: 68 * SizeConfig.heightMultiplier(context),
            width: 343 * SizeConfig.widthMultiplier(context),
            decoration: BoxDecoration(
              color: AppColors.grayscale10,
              borderRadius: BorderRadius.circular(
                  20 * SizeConfig.widthMultiplier(context)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 3; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 40 * SizeConfig.heightMultiplier(context),
                      width: 84 * SizeConfig.widthMultiplier(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            20 * SizeConfig.widthMultiplier(context)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
        ],
      ),
    );
  }
}
