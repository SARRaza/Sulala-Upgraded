import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class AnimalIDWidget extends StatelessWidget {
  final double avatarRadius;
  final String imagePath;
  final String textHead;
  final String textBody;
  final String textID;
  final Function() onPressed;

  const AnimalIDWidget({
    Key? key,
    required this.avatarRadius,
    required this.imagePath,
    required this.textHead,
    required this.textBody,
    required this.onPressed,
    required this.textID,
  }) : super(key: key);

  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: AppColors.grayscale10,
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.widthMultiplier(context) * 15,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier(context) * 9,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      truncateTextWithEllipsis(textHead, 15),
                      style: AppFonts.headline3(
                        color: AppColors.grayscale90,
                      ),
                    ),
                    Text(
                      truncateTextWithEllipsis(textID, 11),
                      style: AppFonts.body2(
                        color: AppColors.grayscale90,
                      ),
                    ),
                  ],
                ),
                Text(
                  truncateTextWithEllipsis(
                      textBody, 20), // Use the truncatedTextBody here
                  style: AppFonts.body2(
                    color: AppColors.grayscale70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier(context) * 15,
          ),
        ],
      ),
    );
  }
}

//Example of use:

// SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.055,
//               child: AnimalIDWidget(
//                 avatarRadius: 30,
//                 imagePath: 'assets/avatars/120px/Cat.png',
//                 textBody: 'Text',
//                 // timeText: "1 hour ago",
//                 textHead:
//                     'animal', // Replace with the actual text you want to display
//                 textID: "199086",
//                 onPressed: () {
//                   // Do something when the row is pressed
//                   // For example, you can navigate to a new page, update the UI, etc.
//                 },
//               ),
//             ),
