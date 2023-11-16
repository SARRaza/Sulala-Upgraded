import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class DisabledTextCheckboxWidget extends StatefulWidget {
  final String text;
  final bool checked;

  const DisabledTextCheckboxWidget({
    Key? key,
    required this.text,
    required this.checked,
  }) : super(key: key);

  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  State<DisabledTextCheckboxWidget> createState() =>
      _DisabledTextCheckboxWidgetState();
}

class _DisabledTextCheckboxWidgetState
    extends State<DisabledTextCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.checked ? AppColors.grayscale50 : AppColors.grayscale20;
    final borderColor =
        widget.checked ? AppColors.grayscale50 : AppColors.grayscale30;
    final checkColor = widget.checked ? AppColors.grayscale0 : null;

    return Row(
      children: [
        SizedBox(
          width: globals.widthMediaQuery * 15,
        ),
        Text(
          widget.truncateTextWithEllipsis(widget.text, 25),
          style: AppFonts.body2(
            color: AppColors.grayscale50,
          ),
        ),

        const Spacer(), // To push the radio button to the right end of the row
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: borderColor,
                width: 1.0,
              ),
            ),
            child: widget.checked
                ? Icon(
                    Icons.check,
                    color: checkColor,
                    size: 16.0,
                  )
                : null,
          ),
        ),
        SizedBox(
          width: globals.widthMediaQuery * 15,
        ),
      ],
    );
  }
}


// Example of use:

  // const DisabledTextCheckboxWidget(
  //                   text: 'Text Checkbox Widget',
  //                   checked: false,
  //                 ),