import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class FamilyTreeItem extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String sex;
  final String id;
  final String tag;
  final bool selected;

  const FamilyTreeItem({
    Key? key, // Add 'Key?' type to the key parameter
    this.imageUrl,
    required this.name,
    required this.sex,
    required this.tag,
    required this.id,
    required this.selected,
  }) : super(key: key); // Call the super constructor with the provided key

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? getImage() {
      if (imageUrl != null) {
        return NetworkImage(imageUrl!);
      } else {
        return const AssetImage("assets/avatars/120px/Horse.png");
      }
    }

    return Column(
      children: [
        (selected)
            ? Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 237, 74), // Shadow color
                      blurRadius: 10, // Spread of the shadow
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: getImage(),
                  radius: SizeConfig.widthMultiplier(context) * 32,
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: getImage(),
                radius: SizeConfig.widthMultiplier(context) * 32,
              ),
        SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: AppFonts.body1(
                color: AppColors.grayscale90,
              ),
            ),
            SizedBox(width: SizeConfig.widthMultiplier(context) * 4),
            sex.toLowerCase() != "male"
                ? Image.asset("assets/icons/frame/24px/16_Gender_female.png")
                : Image.asset("assets/icons/frame/24px/16_Gender_male.png"),
          ],
        ),
        SizedBox(height: SizeConfig.heightMultiplier(context) * 3),
        Text(
          'ID #$id',
          style: AppFonts.caption2(
            color: AppColors.grayscale80,
          ),
        ),
        SizedBox(height: SizeConfig.heightMultiplier(context) * 3),
        Text(
          tag,
          style: AppFonts.caption3(
            color: AppColors.grayscale80,
          ),
        ),
      ],
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
