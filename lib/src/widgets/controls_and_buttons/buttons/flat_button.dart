import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

enum FlatButtonPosition {
  primary,
  left,
  right,
}

class FlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final FlatButtonStatus status;
  final FlatButtonPosition position;

  const FlatButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.status = FlatButtonStatus.idle,
    this.position = FlatButtonPosition.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status == FlatButtonStatus.disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: _getButtonColor(status),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    if (status == FlatButtonStatus.loading) {
      return const NutsActivityIndicator(
        radius: 12,
        activeColor: AppColors.grayscale90,
        tickCount: 8,
        inactiveColor: Colors.transparent,
      );
    } else {
      switch (position) {
        case FlatButtonPosition.left:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                color: _getArrowColor(status),
              ),
              const SizedBox(width: 8), //Don't use MediaQuery here
              Text(
                text,
                style: AppFonts.body1(color: _getTextColor(status)),
              ),
            ],
          );
        case FlatButtonPosition.right:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppFonts.body1(color: _getTextColor(status)),
              ),
              const SizedBox(width: 8), //Don't use MediaQuery here
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

  Color _getButtonColor(FlatButtonStatus status) {
    switch (status) {
      case FlatButtonStatus.idle:
        return Colors.transparent;
      case FlatButtonStatus.pressed:
        return AppColors.grayscale10;
      case FlatButtonStatus.loading:
        return Colors.transparent;
      case FlatButtonStatus.disabled:
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  Color _getArrowColor(FlatButtonStatus status) {
    switch (status) {
      case FlatButtonStatus.idle:
      case FlatButtonStatus.loading:
      case FlatButtonStatus.pressed:
        return AppColors.grayscale90;
      case FlatButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.grayscale90;
    }
  }

  Color _getTextColor(FlatButtonStatus status) {
    switch (status) {
      case FlatButtonStatus.idle:
      case FlatButtonStatus.loading:
      case FlatButtonStatus.pressed:
        return AppColors.grayscale90;
      case FlatButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.grayscale90;
    }
  }
}

enum FlatButtonStatus {
  idle,
  pressed,
  loading,
  disabled,
}

// Example of use:

// SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: MediaQuery.of(context).size.height * 0.05,
//               child: FlatButton(
//                 text: 'Button Text',
//                 onPressed: () {
//                   // Your onPressed logic here
//                 },
//                 status: FlatButtonStatus.loading,
//                 position: FlatButtonPosition.left,
//               ),
//             ),
