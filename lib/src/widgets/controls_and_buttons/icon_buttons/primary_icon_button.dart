import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import '../../../theme/colors/colors.dart';

class PrimaryIconButton extends StatelessWidget {
  final PrimaryIconButtonStatus status;
  final IconData icon;
  final VoidCallback? onPressed;

  const PrimaryIconButton({
    Key? key,
    required this.status,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getBackgroundColor(status),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    switch (status) {
      case PrimaryIconButtonStatus.idle:
      case PrimaryIconButtonStatus.pressed:
        return IconButton(
          onPressed: onPressed,
          icon: _buildIcon(),
          splashRadius: 24,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
          alignment: Alignment.center,
        );
      case PrimaryIconButtonStatus.loading:
        return const SizedBox(
          height: 39,
          child: NutsActivityIndicator(
            radius: 12,
            activeColor: AppColors.grayscale0,
            tickCount: 8,
            inactiveColor: Colors.transparent,
          ),
        );
      case PrimaryIconButtonStatus.disabled:
        return IconButton(
          onPressed: null,
          icon: _buildIcon(),
          splashRadius: 24,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
          alignment: Alignment.center,
        );
    }
  }

  Icon _buildIcon() {
    return Icon(
      icon,
      size: 24,
      color: AppColors.grayscale0,
    );
  }

  Color _getBackgroundColor(PrimaryIconButtonStatus status) {
    switch (status) {
      case PrimaryIconButtonStatus.idle:
        return AppColors.primary50;
      case PrimaryIconButtonStatus.pressed:
        return AppColors.primary40;
      case PrimaryIconButtonStatus.loading:
        return AppColors.primary50;
      case PrimaryIconButtonStatus.disabled:
        return AppColors.grayscale50;
    }
  }
}

enum PrimaryIconButtonStatus {
  idle,
  pressed,
  loading,
  disabled,
}
