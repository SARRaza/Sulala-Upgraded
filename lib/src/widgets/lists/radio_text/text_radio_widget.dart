import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class TextRadioWidget extends StatefulWidget {
  final String text;
  final bool isActive;
  final Function(bool) onChanged;

  const TextRadioWidget({
    Key? key,
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
  State<TextRadioWidget> createState() => _TextRadioWidgetState();
}

class _TextRadioWidgetState extends State<TextRadioWidget> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
        widget.onChanged(isActive);
      },
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.widthMultiplier(context) * 15,
          ),
          Text(
            widget.truncateTextWithEllipsis(widget.text, 25),
            style: AppFonts.body2(
              color: AppColors.grayscale90,
            ),
          ),
          const Spacer(), // To push the radio button to the right end of the row
          GestureDetector(
            onTap: () {
              setState(() {
                isActive = !isActive;
              });
              widget.onChanged(isActive);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isActive ? AppColors.primary20 : AppColors.grayscale0,
                border: Border.all(
                  width: 1,
                  color: isActive ? AppColors.primary20 : AppColors.grayscale30,
                ),
              ),
              child: isActive
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.grayscale0,
                        ),
                      ),
                    )
                  : null,
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

// Example of use:

// TextRadioWidget(
//                 text: 'Text Radio Widget',
//                 isActive:
//                     true, // Replace with the actual boolean value for the radio button state
//                 onChanged: (isActive) {
//                   // Do something when the radio button is toggled
//                   if (isActive) {
//                     // Handle the case when the radio button is active
//                     print('Radio button is active');
//                   } else {
//                     // Handle the case when the radio button is not active
//                     print('Radio button is not active');
//                   }
//                 },
//               ),
