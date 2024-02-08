import 'package:flutter/material.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class AnimalListWidget extends StatelessWidget {
  final double avatarRadius;
  final String imagePath;
  final String textHead;
  final String textBody;
  final Function() onPressed;

  const AnimalListWidget({
    Key? key,
    required this.avatarRadius,
    required this.imagePath,
    required this.textHead,
    required this.textBody,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: AppColors.grayscale10,
      onTap: onPressed,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier(context) * 9,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  textHead,
                  style: AppFonts.headline3(
                    color: AppColors.grayscale90,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  textBody,
                  style: AppFonts.body2(
                    color: AppColors.grayscale70,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}