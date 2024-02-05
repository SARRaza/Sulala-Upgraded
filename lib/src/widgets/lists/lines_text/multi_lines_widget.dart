import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class MultiLinesWidget extends StatelessWidget {
  final String textHead;
  final String textBody;
  final Function() onPressed;

  const MultiLinesWidget({
    Key? key,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                width: SizeConfig.widthMultiplier(context) * 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncateTextWithEllipsis(textHead, 15),
                    style: AppFonts.body1(
                      color: AppColors.grayscale90,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 4),
                  Text(
                    truncateTextWithEllipsis(textBody, 20),
                    style: AppFonts.body2(
                      color: AppColors.grayscale70,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: AppColors.primary40,
                  size: SizeConfig.widthMultiplier(context) * 15),
              SizedBox(
                width: SizeConfig.widthMultiplier(context) * 15,
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier(context) * 14,
          ),
          Container(
            //Check it again please (it is taking the width of the screen)I need it to take the width of the row
            width: SizeConfig.widthMultiplier(context) * 337,
            height: 1,
            color: AppColors.grayscale20,
          ),
        ],
      ),
    );
  }
}

// Example of use:

//  SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: MediaQuery.of(context).size.height * 0.09,
//               child: MultiLinesWidget(
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
