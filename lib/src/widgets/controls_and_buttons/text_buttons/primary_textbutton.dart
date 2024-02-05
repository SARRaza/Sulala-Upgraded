import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../../theme/colors/colors.dart';

enum TextButtonPosition {
  primary,
  left,
  right,
}

class PrimaryTextButton extends StatelessWidget {
  final TextStatus status;
  final VoidCallback? onPressed;
  final String text;
  final TextButtonPosition position;

  const PrimaryTextButton({
    Key? key,
    required this.status,
    required this.text,
    this.onPressed,
    this.position = TextButtonPosition.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _getButtonEnabled(status) ? onPressed : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.grayscale50;
          }
          return _getTextColor(status);
        }),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    switch (status) {
      case TextStatus.idle:
      case TextStatus.pressed:
        return _buildTextWithArrow(
          text,
          _getTextColor(status),
          position == TextButtonPosition.right,
          position == TextButtonPosition.left,
        );
      case TextStatus.loading:
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: NutsActivityIndicator(
                radius: 12,
                activeColor: AppColors.grayscale0,
                tickCount: 8,
                inactiveColor: Colors.transparent,
              ),
            ),
          ],
        );
      case TextStatus.disabled:
        return _buildTextWithArrow(
          text,
          AppColors.grayscale50,
          position == TextButtonPosition.right,
          position == TextButtonPosition.left,
        );
    }
  }

  Widget _buildTextWithArrow(
    String text,
    Color textColor,
    bool showRightArrow,
    bool showLeftArrow,
  ) {
    if (showLeftArrow) {
      return Row(
        children: [
          const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.primary40, size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: textColor),
          ), //Don't use MediaQuery Here
        ],
      );
    } else if (showRightArrow) {
      return Row(
        children: [
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
          const SizedBox(width: 8), //Don't use MediaQuery Here
          const Icon(Icons.arrow_forward_ios_rounded,
              color: AppColors.primary40, size: 14),
        ],
      );
    }
    return Text(
      text,
      style: TextStyle(color: textColor),
    );
  }

  bool _getButtonEnabled(TextStatus status) {
    return status != TextStatus.disabled && TextStatus.loading != status;
  }

  Color _getTextColor(TextStatus status) {
    switch (status) {
      case TextStatus.idle:
        return AppColors.primary40;
      case TextStatus.pressed:
        return AppColors.primary50;
      case TextStatus.loading:
        return AppColors.grayscale90;
      case TextStatus.disabled:
        return AppColors.grayscale50;
    }
  }
}

enum TextStatus {
  idle,
  pressed,
  loading,
  disabled,
}

// Example of use:

// SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: MediaQuery.of(context).size.height * 0.05,
//               child: PrimaryTextButton(
//                 status: TextStatus.idle,
//                 onPressed: () {},
//                 text: 'Text Button',
//                 position: TextButtonPosition.right,
//               ),
//             ),
