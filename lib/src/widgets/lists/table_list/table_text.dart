import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class TableText extends StatefulWidget {
  final String text1;
  final String text2;

  const TableText({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  State<TableText> createState() => _TableTextState();
}

class _TableTextState extends State<TableText> {
  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier(context) * 15,
            ),
            Text(
              truncateTextWithEllipsis(widget.text1, 25),
              style: AppFonts.body2(
                color: AppColors.grayscale70,
              ),
            ),
            const Spacer(),
            Text(
              widget.text2,
              style: AppFonts.body2(
                color: AppColors.grayscale90,
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier(context) * 15,
            ),
          ],
        ),
      ],
    );
  }
}

// Exapmle of use:

// TextButtonTextWidget(
//                     textHead: 'Text Button',
//                     textButton: 'Button',
//                     onPressed: (bool isChecked) {
//                       print('Text Button Pressed');
//                     },
//                   ),
