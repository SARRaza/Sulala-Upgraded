import 'package:flutter/material.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../controls_and_buttons/radio/radio_active.dart';

class AvatarTextRadio extends StatefulWidget {
  final double avatarRadius;
  final String imagePath;
  final String text;
  final bool isActive;
  final Function(bool) onChanged;

  const AvatarTextRadio({
    Key? key,
    required this.avatarRadius,
    required this.imagePath,
    required this.text,
    required this.isActive,
    required this.onChanged,
  }) : super(key: key);

  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  State<AvatarTextRadio> createState() => _AvatarTextRadioState();
}

class _AvatarTextRadioState extends State<AvatarTextRadio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: widget.avatarRadius,
          backgroundImage: AssetImage(widget.imagePath),
        ),
        SizedBox(
            width: globals.widthMediaQuery *
                9), // You can adjust the spacing between avatar and text
        Text(
          widget.truncateTextWithEllipsis(widget.text, 15),
          style: AppFonts.body2(
            color: AppColors.grayscale90,
          ),
        ),

        const Spacer(), // To push the radio button to the right end of the row
        RadioActive(
          isActive: widget.isActive,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}


// Example of use:

// SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               height: MediaQuery.of(context).size.height * 0.1,
//               child: AvatarTextRadio(
//                 avatarRadius:
//                     30.0, // Set the desired radius for the circle avatar
//                 imagePath:
//                     'assets/avatars/120px/Duck.png', // Replace with the actual image path
//                 text:
//                     'Text', // Replace with the actual text you want to display
//                 isActive:
//                     true, // Replace with the actual boolean value for the radio button state
//                 onChanged: (isActive) {
//                   // Do something when the radio button is toggled
//                   if (isActive) {
//                     // Handle the case when the radio button is active
//                   } else {
//                     // Handle the case when the radio button is not active
//                   }
//                 },
//               ),
//             ),