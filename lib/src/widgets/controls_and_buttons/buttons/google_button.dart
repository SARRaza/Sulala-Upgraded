import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class GoogleButton extends StatelessWidget {
  final GoogleButtonStatus status;
  final VoidCallback? onPressed;

  const GoogleButton({
    Key? key,
    required this.status,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 52,
      child: ElevatedButton(
        onPressed: status == GoogleButtonStatus.disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getButtonColor(status),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (status == GoogleButtonStatus.loading) {
      return const Center(
        child: NutsActivityIndicator(
          radius: 12,
          activeColor: AppColors.grayscale90,
          tickCount: 8,
          inactiveColor: Colors.transparent,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/icons/frame/24px/24_Google.png',
            width: 24,
            height: 24,
          ),
          Text(
            'Continue With Google'.tr,
            style: AppFonts.body1(color: _getTextColor(status)),
          ),
          const SizedBox(width: 30),
        ],
      );
    }
  }

  Color _getButtonColor(GoogleButtonStatus status) {
    switch (status) {
      case GoogleButtonStatus.idle:
        return AppColors.grayscale10;
      case GoogleButtonStatus.pressed:
        return AppColors.grayscale20;
      case GoogleButtonStatus.loading:
        return AppColors.grayscale10;
      case GoogleButtonStatus.disabled:
        return AppColors.grayscale20;
      default:
        return AppColors.grayscale10;
    }
  }

  Color _getTextColor(GoogleButtonStatus status) {
    switch (status) {
      case GoogleButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.grayscale90;
    }
  }
}

enum GoogleButtonStatus {
  idle,
  pressed,
  loading,
  disabled,
}
