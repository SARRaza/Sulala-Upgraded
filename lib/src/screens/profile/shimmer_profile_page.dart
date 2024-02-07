import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/globals.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import 'list_of_staff.dart';

class ShimmerProfilePage extends StatelessWidget {
  const ShimmerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40 * SizeConfig.heightMultiplier(context)),
          ShimmerContainer.circular(
            height: 120 * SizeConfig.heightMultiplier(context),
            width: 120 * SizeConfig.widthMultiplier(context),
          ),
          SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
          ShimmerContainer.rectangular(
            height: 28 * SizeConfig.heightMultiplier(context),
            width: 160 * SizeConfig.widthMultiplier(context),
            borderRadius: 20 * SizeConfig.widthMultiplier(context),
          ),
          SizedBox(height: 4 * SizeConfig.heightMultiplier(context)),
          ShimmerContainer.rectangular(
            height: 18 * SizeConfig.heightMultiplier(context),
            width: 160 * SizeConfig.widthMultiplier(context),
            borderRadius: 20 * SizeConfig.widthMultiplier(context),
          ),
          SizedBox(height: 4 * SizeConfig.heightMultiplier(context)),
          ShimmerContainer.rectangular(
            height: 18 * SizeConfig.heightMultiplier(context),
            width: 160 * SizeConfig.widthMultiplier(context),
            borderRadius: 20 * SizeConfig.widthMultiplier(context),
          ),
          SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
          ShimmerContainer.rectangular(
            height: 20 * SizeConfig.heightMultiplier(context),
            width: 160 * SizeConfig.widthMultiplier(context),
            borderRadius: 20 * SizeConfig.widthMultiplier(context),
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
              },
              text: 'Collaboration'.tr,
              position: PrimaryButtonPosition.right,
            ),
          ),
          SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
          ShimmerContainer.horizontal(
            height: 68 * SizeConfig.heightMultiplier(context),
            width: 343 * SizeConfig.widthMultiplier(context),
            itemCount: 3,
          ),
          SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
        ],
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final int? itemCount;
  final bool circular;

  const ShimmerContainer({
    required this.height,
    required this.width,
    this.borderRadius = 0.0,
    this.itemCount,
    this.circular = false,
    Key? key,
  }) : super(key: key);

  factory ShimmerContainer.rectangular({
    required double height,
    required double width,
    required double borderRadius,
  }) {
    return ShimmerContainer(
      height: height,
      width: width,
      borderRadius: borderRadius,
    );
  }

  factory ShimmerContainer.circular({
    required double height,
    required double width,
  }) {
    return ShimmerContainer(
      height: height,
      width: width,
      borderRadius: height / 2, // Make it circular
      circular: true,
    );
  }

  factory ShimmerContainer.horizontal({
    required double height,
    required double width,
    required int itemCount,
  }) {
    return ShimmerContainer(
      height: height,
      width: width,
      itemCount: itemCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (itemCount != null && itemCount! > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          itemCount!,
              (index) => _buildItem(),
        ),
      );
    } else {
      return _buildItem();
    }
  }

  Widget _buildItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: circular
              ? null
              : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
