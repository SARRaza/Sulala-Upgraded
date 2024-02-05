import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

enum SecondaryButtonPosition {
  primary,
  left,
  right,
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final SecondaryButtonStatus status;
  final SecondaryButtonPosition position;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.status = SecondaryButtonStatus.idle,
    this.position = SecondaryButtonPosition.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status == SecondaryButtonStatus.disabled ? null : onPressed,
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
    if (status == SecondaryButtonStatus.loading) {
      return const NutsActivityIndicator(
        radius: 12,
        activeColor: AppColors.grayscale90,
        tickCount: 8,
        inactiveColor: Colors.transparent,
      );
    } else {
      switch (position) {
        case SecondaryButtonPosition.left:
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
        case SecondaryButtonPosition.right:
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

  Color _getButtonColor(SecondaryButtonStatus status) {
    switch (status) {
      case SecondaryButtonStatus.idle:
        return AppColors.grayscale10;
      case SecondaryButtonStatus.pressed:
        return AppColors.grayscale20;
      case SecondaryButtonStatus.loading:
        return AppColors.grayscale10;
      case SecondaryButtonStatus.disabled:
        return AppColors.grayscale20;
      default:
        return AppColors.grayscale10;
    }
  }

  Color _getArrowColor(SecondaryButtonStatus status) {
    switch (status) {
      case SecondaryButtonStatus.idle:
      case SecondaryButtonStatus.loading:
      case SecondaryButtonStatus.pressed:
        return AppColors.grayscale90;
      case SecondaryButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.grayscale90;
    }
  }

  Color _getTextColor(SecondaryButtonStatus status) {
    switch (status) {
      case SecondaryButtonStatus.idle:
      case SecondaryButtonStatus.pressed:
      case SecondaryButtonStatus.loading:
        return AppColors.grayscale90;
      case SecondaryButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.grayscale90;
    }
  }
}

enum SecondaryButtonStatus {
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
