import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;
import '../../../theme/fonts/fonts.dart';

class Tags extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPress;
  final TagStatus status;

  const Tags({
    Key? key,
    required this.text,
    this.icon,
    this.onPress,
    this.status = TagStatus.notActive,
  }) : super(key: key);

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color iconColor;

    switch (widget.status) {
      case TagStatus.active:
        backgroundColor = AppColors.secondary30;
        textColor = AppColors.grayscale90;
        iconColor = AppColors.grayscale90;
        break;
      case TagStatus.notActive:
        backgroundColor = AppColors.grayscale10;
        textColor = AppColors.grayscale90;
        iconColor = AppColors.grayscale90;
        break;
      case TagStatus.disabled:
        backgroundColor = AppColors.grayscale10;
        textColor = AppColors.grayscale50;
        iconColor = AppColors.grayscale50;
        break;
    }

    return ElevatedButton(
      onPressed: widget.onPress,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null)
            Row(
              children: [
                Icon(
                  widget.icon,
                  color: iconColor,
                  size: globals.widthMediaQuery * 30,
                ),
                SizedBox(width: globals.widthMediaQuery * 8),
              ],
            ),
          Text(widget.text,
              style: AppFonts.body2(color: AppColors.grayscale90)),
        ],
      ),
    );
  }
}

enum TagStatus {
  active,
  notActive,
  disabled,
}


//Example of use:
          //  Tags(
          //     text: 'Tag 1',
          //     icon: Icons.ac_unit,
          //     onPress: () {
          //       // Handle tag click
          //     },
          //     status: TagStatus.active,
          //   ),
          //   Tags(
          //     text: 'Tag 1',
          //     icon: Icons.ac_unit,
          //     onPress: () {
          //       // Handle tag click
          //     },
          //     status: TagStatus.notActive,
          //   ),±±
          //   Tags(
          //     text: 'Tag 1',
          //     icon: Icons.ac_unit,
          //     onPress: () {
          //       // Handle tag click
          //     },
          //     status: TagStatus.disabled,
          //   ),


//You can also pass images instead of icons.