import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class TextCheckboxWidget extends StatefulWidget {
  final String text;
  final bool checked;
  final Function(bool) onChanged;

  const TextCheckboxWidget({
    Key? key,
    required this.text,
    required this.checked,
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
  State<TextCheckboxWidget> createState() => _TextCheckboxWidgetState();
}

class _TextCheckboxWidgetState extends State<TextCheckboxWidget> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        _checked ? AppColors.primary20 : AppColors.grayscale0;
    final borderColor = _checked ? AppColors.primary20 : AppColors.grayscale30;
    final checkColor = _checked ? AppColors.grayscale0 : null;

    return InkWell(
      onTap: _toggleChecked,
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
            onTap: _toggleChecked,
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
              child: _checked
                  ? Icon(
                      Icons.check,
                      color: checkColor,
                      size: 16.0,
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

  void _toggleChecked() {
    setState(() {
      _checked = !_checked;
      widget.onChanged(_checked);
    });
  }
}

// Example of use:

// TextCheckboxWidget(
//                     text: 'Text Radio Widget',
//                     checked: true,
//                     onChanged: (isActive) {
//                       // Do something when the radio button is toggled
//                       if (isActive) {
//                         // Handle the case when the radio button is active
//                         print('Box Checked is active');
//                       } else {
//                         // Handle the case when the radio button is not active
//                         print('Box Ckecked is not active');
//                       }
//                     },
//                   ),
