import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

enum NavigateButtonPosition {
  primary,
  left,
  right,
}

class NavigateButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final NavigateButtonStatus status;
  final NavigateButtonPosition position;

  const NavigateButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.status = NavigateButtonStatus.idle,
    this.position = NavigateButtonPosition.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status == NavigateButtonStatus.disabled ? null : onPressed,
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
    if (status == NavigateButtonStatus.loading) {
      return const NutsActivityIndicator(
        radius: 12,
        activeColor: AppColors.error100,
        tickCount: 8,
        inactiveColor: Colors.transparent,
      );
    } else {
      switch (position) {
        case NavigateButtonPosition.left:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                color: _getArrowColor(status),
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: AppFonts.body1(color: _getTextColor(status)),
              ),
            ],
          );
        case NavigateButtonPosition.right:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppFonts.body1(color: _getTextColor(status)),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: _getArrowColor(status),
              ),
            ],
          );
        default:
          return Text(
            text,
            style: AppFonts.body1(color: _getTextColor(status)),
          );
      }
    }
  }

  Color _getButtonColor(NavigateButtonStatus status) {
    switch (status) {
      case NavigateButtonStatus.idle:
        return AppColors.grayscale10;
      case NavigateButtonStatus.pressed:
        return AppColors.grayscale20;
      case NavigateButtonStatus.loading:
        return AppColors.grayscale10;
      case NavigateButtonStatus.disabled:
        return AppColors.grayscale20;
      default:
        return AppColors.grayscale10;
    }
  }

  Color _getArrowColor(NavigateButtonStatus status) {
    switch (status) {
      case NavigateButtonStatus.idle:
      case NavigateButtonStatus.loading:
      case NavigateButtonStatus.pressed:
        return AppColors.error100;
      case NavigateButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.error100;
    }
  }

  Color _getTextColor(NavigateButtonStatus status) {
    switch (status) {
      case NavigateButtonStatus.idle:
      case NavigateButtonStatus.loading:
      case NavigateButtonStatus.pressed:
        return AppColors.error100;
      case NavigateButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.error100;
    }
  }
}

enum NavigateButtonStatus {
  idle,
  pressed,
  loading,
  disabled,
}


// Example od use:

// SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: MediaQuery.of(context).size.height * 0.05,
//               child: NavigateButton(
//                 text: 'Button Text',
//                 onPressed: () {
//                   // Your onPressed logic here
//                 },
//                 status: NavigateButtonStatus.idle,
//                 position: NavigateButtonPosition.left,
//               ),
//             ),