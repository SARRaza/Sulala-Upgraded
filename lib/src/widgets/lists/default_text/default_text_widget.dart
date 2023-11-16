import 'package:flutter/material.dart';

import 'package:sulala_app/src/data/globals.dart' as globals;

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class DefaultTextWidget extends StatefulWidget {
  final String textHead;
  final Function(bool isChecked) onPressed;

  const DefaultTextWidget({
    Key? key,
    required this.textHead,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<DefaultTextWidget> createState() => _DefaultTextWidgetState();
}

class _DefaultTextWidgetState extends State<DefaultTextWidget> {
  bool _isChecked = false;

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
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onPressed(_isChecked);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: globals.widthMediaQuery * 15,
              ),
              Text(
                truncateTextWithEllipsis(widget.textHead, 25),
                style: AppFonts.body2(
                  color: AppColors.grayscale90,
                ),
              ),
              const Spacer(),
              if (_isChecked)
                Image.asset(
                  "assets/icons/frame/24px/24_Check.png",
                ),
              SizedBox(
                width: globals.widthMediaQuery * 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Exapmle of use:

// bool _isRowChecked = false;

// SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.055,
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.09,
//                 child: DefaultTextListWidget(
//                   textHead: 'Hello',
//                   onPressed: (isChecked) {
//                     setState(() {
//                       _isRowChecked = isChecked;
//                     });
//                     if (_isRowChecked) {
//                       // Do something when the row is checked
//                       print("Checked");
//                     } else {
//                       // Do something else when the row is unchecked
//                       print("Unchecked");
//                     }
//                   },
//                 ),
//               ),
//             ),