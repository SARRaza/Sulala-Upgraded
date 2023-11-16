import 'package:flutter/material.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class TextToggleWidget extends StatefulWidget {
  final String text;
  final bool isActive;
  final Function(bool) onChanged;

  const TextToggleWidget({
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
  State<TextToggleWidget> createState() => _TextToggleWidgetState();
}

class _TextToggleWidgetState extends State<TextToggleWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        _value ? AppColors.primary20 : AppColors.grayscale20;
    final circleColor = _value ? AppColors.grayscale0 : AppColors.grayscale0;

    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged(_value);
      },
      child: Row(
        children: [
          SizedBox(
            width: globals.widthMediaQuery * 15,
          ),
          Text(
            widget.truncateTextWithEllipsis(widget.text, 25),
            style: AppFonts.body2(
              color: AppColors.grayscale90,
            ),
          ),
          const Spacer(), // To push the radio button to the right end of the row
          GestureDetector(
            onTap: _toggleValue,
            child: Container(
              width: 50.0,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: backgroundColor,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _value ? 20.0 : 0.0,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: circleColor,
                        border: Border.all(
                          color: backgroundColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: globals.widthMediaQuery * 15,
          ),
        ],
      ),
    );
  }

  void _toggleValue() {
    setState(() {
      _value = !_value;
      widget.onChanged(_value);
    });
  }
}


// Example of use:

// TextToggleWidget(
//                     text: 'Text Toggle Widget',
//                     isActive:
//                         true, // Replace with the actual boolean value for the radio button state
//                     onChanged: (isActive) {
//                       // Do something when the radio button is toggled
//                       if (isActive) {
//                         // Handle the case when the radio button is active
//                         print('Toggle button is active');
//                       } else {
//                         // Handle the case when the radio button is not active
//                         print('Toggle button is not active');
//                       }
//                     },
//                   ),