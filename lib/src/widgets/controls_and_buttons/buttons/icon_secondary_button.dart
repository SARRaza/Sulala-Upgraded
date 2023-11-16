import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';


class IconSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final SecondaryIconStatus status;
  final String iconPath;

  const IconSecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.status = SecondaryIconStatus.idle,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status == SecondaryIconStatus.disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonColor(status),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    if (status == SecondaryIconStatus.loading) {
      return const NutsActivityIndicator(
        radius: 12,
        activeColor: AppColors.grayscale90,
        tickCount: 8,
        inactiveColor: Colors.transparent,
      );

    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppFonts.body1(color: _getTextColor(status)),
          ),
        ],
      );
    }
  }
}

Color _getButtonColor(SecondaryIconStatus status) {
  switch (status) {
    case SecondaryIconStatus.idle:
      return AppColors.grayscale10;
    case SecondaryIconStatus.pressed:
      return AppColors.grayscale20;
    case SecondaryIconStatus.loading:
      return AppColors.grayscale10;
    case SecondaryIconStatus.disabled:
      return AppColors.grayscale20;
    default:
      return AppColors.grayscale10;
  }
}

Color _getTextColor(SecondaryIconStatus status) {
  switch (status) {
    case SecondaryIconStatus.idle:
    case SecondaryIconStatus.pressed:
    case SecondaryIconStatus.loading:
      return AppColors.grayscale90;
    case SecondaryIconStatus.disabled:
      return AppColors.grayscale50;
    default:
      return AppColors.grayscale90;
  }
}

enum SecondaryIconStatus {
  idle,
  pressed,
  loading,
  disabled,
}


// Example of use:

// SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: MediaQuery.of(context).size.height * 0.05,
//               child: SecondaryButton(
//                 text: 'Button Text',
//                 onPressed: () {
//                   // Your onPressed logic here
//                 },
//                 status: SecondaryButtonStatus.idle,
//                 position: SecondaryButtonPosition.right,
//               ),
//             ),