import 'package:flutter/material.dart';
import '../../data/classes/ovi_variables.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class ParentsItem extends StatelessWidget {
  final OviVariables oviDetails;
  final void Function()? onTap;

  const ParentsItem(
      {Key? key,
      required this.oviDetails,
      this.onTap})
      : super(key: key); // Call the super constructor with the provided key

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: oviDetails.selectedOviImage,
            radius: 60 * SizeConfig.widthMultiplier(context),
          ),
          SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              oviDetails.selectedOviGender.toLowerCase() != "male"
                  ? Image.asset(
                      "assets/icons/frame/24px/16_Gender_female_1_5.png")
                  : Image.asset(
                      "assets/icons/frame/24px/16_Gender_male_1_5.png"),
              SizedBox(width: SizeConfig.widthMultiplier(context) * 3.75),
              Text(
                oviDetails.animalName,
                style: AppFonts.title5(
                  color: AppColors.grayscale90,
                ),
              ),
            ],
          ),
          Text(
            'ID #${oviDetails.id}',
            style: AppFonts.body2(
              color: AppColors.grayscale80,
            ),
          ),
          Text(
            oviDetails.age.toString(),
            style: AppFonts.body2(
              color: AppColors.grayscale80,
            ),
          ),
        ],
      ),
    );
  }


}
