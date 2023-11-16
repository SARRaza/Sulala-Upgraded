import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors/colors.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import 'list_of_staff.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class ShimmerProfilePage extends StatelessWidget {
  const ShimmerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 40 * globals.heightMediaQuery),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 120 * globals.heightMediaQuery,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                )),
          ),
          SizedBox(height: 16 * globals.heightMediaQuery),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 28 * globals.heightMediaQuery,
                width: 160 * globals.widthMediaQuery,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20 * globals.widthMediaQuery),
                )),
          ),
          SizedBox(height: 4 * globals.heightMediaQuery),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 18 * globals.heightMediaQuery,
                width: 160 * globals.widthMediaQuery,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20 * globals.widthMediaQuery),
                )),
          ),
          SizedBox(height: 4 * globals.heightMediaQuery),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 18 * globals.heightMediaQuery,
                width: 160 * globals.widthMediaQuery,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20 * globals.widthMediaQuery),
                )),
          ),
          SizedBox(height: 16 * globals.heightMediaQuery),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 20 * globals.heightMediaQuery,
                width: 160 * globals.widthMediaQuery,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20 * globals.widthMediaQuery),
                )),
          ),
          SizedBox(height: 32 * globals.heightMediaQuery),
          SizedBox(
            height: 40 * globals.heightMediaQuery,
            width: 343 * globals.widthMediaQuery,
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
          SizedBox(height: 24 * globals.heightMediaQuery),
          Container(
            height: 68 * globals.heightMediaQuery,
            width: 343 * globals.widthMediaQuery,
            decoration: BoxDecoration(
              color: AppColors.grayscale10,
              borderRadius: BorderRadius.circular(20 * globals.widthMediaQuery),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 3; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 40 * globals.heightMediaQuery,
                      width: 84 * globals.widthMediaQuery,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20 * globals.widthMediaQuery),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 24 * globals.heightMediaQuery),
        ],
      ),
    );
  }
}
