import 'package:flutter/material.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class StaffListWidget extends StatelessWidget {
  final double avatarRadius;
  final String imagePath;
  final String textHead;
  final String textBody;
  final Function() onPressed;

  const StaffListWidget({
    Key? key,
    required this.avatarRadius,
    required this.imagePath,
    required this.textHead,
    required this.textBody,
    required this.onPressed,
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
            width: globals.widthMediaQuery * 15,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(
            width: globals.widthMediaQuery * 9,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                truncateTextWithEllipsis(textHead, 15),
                style: AppFonts.headline3(
                  color: AppColors.grayscale90,
                ),
              ),
              Text(
                truncateTextWithEllipsis(textBody, 20),
                style: AppFonts.body2(
                  color: AppColors.grayscale70,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.primary40,
            size: globals.widthMediaQuery * 13,
          ),
          SizedBox(
            width: globals.widthMediaQuery * 15,
          ),
        ],
      ),
    );
  }
}

// Example of use:

// SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: MediaQuery.of(context).size.height * 0.09,
//               child: StaffListWidget(
//                 avatarRadius:
//                     30.0, // Set the desired radius for the circle avatar
//                 imagePath:
//                     'assets/avatars/120px/Duck.png', // Replace with the actual image path
//                 textHead:
//                     'Hello', // Replace with the actual text you want to display
//                 textBody:
//                     'Here', // Replace with the actual text you want to display
//                 onPressed: () {
//                   // Do something when the row is pressed
//                   // For example, you can navigate to a new page, update the UI, etc.
//                 },
//               ),
//             ),