// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/screens/create_animal/owned_animal_detail_reg_mode.dart';
import '../../data/classes/ovi_variables.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class ParentsItem extends StatelessWidget {
  final ImageProvider? imageFile;
  final String name;
  final String sex;
  final String id;
  final String age;
  final OviVariables OviDetails;
  final void Function()? onTap;

  const ParentsItem(
      {Key? key, // Add 'Key?' type to the key parameter
      this.imageFile,
      required this.name,
      required this.OviDetails,
      required this.sex,
      required this.age,
      required this.id,
      this.onTap})
      : super(key: key); // Call the super constructor with the provided key

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? getImage() {
      if (imageFile != null) {
        return imageFile!;
      } else {
        return const AssetImage("assets/avatars/120px/Horse.png");
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: getImage(),
            radius: 60 * SizeConfig.widthMultiplier(context),
          ),
          SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sex.toLowerCase() != "male"
                  ? Image.asset(
                      "assets/icons/frame/24px/16_Gender_female_1_5.png")
                  : Image.asset(
                      "assets/icons/frame/24px/16_Gender_male_1_5.png"),
              SizedBox(width: SizeConfig.widthMultiplier(context) * 3.75),
              Text(
                name,
                style: AppFonts.title5(
                  color: AppColors.grayscale90,
                ),
              ),
            ],
          ),
          Text(
            'ID #$id',
            style: AppFonts.body2(
              color: AppColors.grayscale80,
            ),
          ),
          Text(
            age,
            style: AppFonts.body2(
              color: AppColors.grayscale80,
            ),
          ),
        ],
      ),
    );
  }
}

// Example of use:

// const FamilyTreeItem(
//                     id: "12345",
//                     name: "Harry",
//                     sex: "Male",
//                     tag: "Borrower",
//                     imageUrl: null,
//                   ),
