import 'package:flutter/material.dart';

import 'package:sulala_app/src/data/globals.dart' as globals;

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class NotificationListWidget extends StatelessWidget {
  final double avatarRadius;
  final String imagePath;
  final String textHead;
  final String textBody;
  final String textTime;
  final Function() onPressed;

  const NotificationListWidget({
    Key? key,
    required this.avatarRadius,
    required this.imagePath,
    required this.textHead,
    required this.textBody,
    required this.onPressed,
    required this.textTime,
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
                truncateTextWithEllipsis(
                    textBody, 20), // Use the truncatedTextBody here
                style: AppFonts.body2(
                  color: AppColors.grayscale70,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            truncateTextWithEllipsis(textTime, 11),
            style: AppFonts.body2(
              color: AppColors.grayscale60,
            ),
          ),
          SizedBox(
            width: globals.widthMediaQuery * 15,
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
//               child: NotificationListWidget(
//                 avatarRadius: 30,
//                 imagePath: 'assets/avatars/120px/Cat.png',
//                 textBody: 'Text',
//                 // timeText: "1 hour ago",
//                 textHead:
//                     'animal', // Replace with the actual text you want to display
//                 textTime: "1 hour ago",
//                 onPressed: () {
//                   // Do something when the row is pressed
//                   // For example, you can navigate to a new page, update the UI, etc.
//                 },
//               ),
//             ),