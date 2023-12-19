import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class AppleButton extends StatelessWidget {
  final AppleButtonStatus status;
  final VoidCallback? onPressed;

  const AppleButton({
    Key? key,
    required this.status,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status == AppleButtonStatus.disabled ? null : onPressed,
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
    if (status == AppleButtonStatus.loading) {
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
            'assets/icons/frame/24px/24_Apple.png',
            width: 24,
            height: 24,
          ),
          Text(
            'Continue With Apple'.tr,
            style: AppFonts.body1(
              color: _getTextColor(status),
            ),
          ),
          const SizedBox(width: 30),
        ],
      );
    }
  }

  Color _getButtonColor(AppleButtonStatus status) {
    switch (status) {
      case AppleButtonStatus.idle:
        return AppColors.grayscale10;
      case AppleButtonStatus.pressed:
        return AppColors.grayscale20;
      case AppleButtonStatus.loading:
        return AppColors.grayscale10;
      case AppleButtonStatus.disabled:
        return AppColors.grayscale20;
      default:
        return AppColors.grayscale10;
    }
  }

  Color _getTextColor(AppleButtonStatus status) {
    switch (status) {
      case AppleButtonStatus.disabled:
        return AppColors.grayscale50;
      default:
        return AppColors.grayscale90;
    }
  }
}

enum AppleButtonStatus {
  idle,
  pressed,
  loading,
  disabled,
}
