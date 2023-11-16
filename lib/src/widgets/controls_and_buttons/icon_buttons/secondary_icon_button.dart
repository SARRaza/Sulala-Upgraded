import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../../../theme/colors/colors.dart';


class SecondaryIconButton extends StatelessWidget {
  final SecondaryIconButtonStatus status;
  final IconData icon;
  final VoidCallback? onPressed;

  const SecondaryIconButton({
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
      case SecondaryIconButtonStatus.idle:
      case SecondaryIconButtonStatus.pressed:
        return IconButton(
          onPressed: onPressed,
          icon: _buildIcon(),
          splashRadius: 24,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
          alignment: Alignment.center,
        );
      case SecondaryIconButtonStatus.loading:
        return const SizedBox(
          height: 39,
          child: NutsActivityIndicator(
            radius: 12,
            activeColor: AppColors.grayscale90,
            tickCount: 8,
            inactiveColor: Colors.transparent,
          ),
        );
      case SecondaryIconButtonStatus.disabled:
        return IconButton(
          onPressed: null,
          icon: Icon(
            icon,
            size: 24,
            color: AppColors.grayscale50,
          ),
          splashRadius: 24,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
          alignment: Alignment.center,
          color: AppColors.grayscale50,
        );
    }
  }

  Icon _buildIcon() {
    return Icon(
      icon,
      size: 24,
      color: AppColors.grayscale90,
    );
  }

  Color _getBackgroundColor(SecondaryIconButtonStatus status) {
    switch (status) {
      case SecondaryIconButtonStatus.idle:
        return AppColors.grayscale10;
      case SecondaryIconButtonStatus.pressed:
        return AppColors.grayscale20;
      case SecondaryIconButtonStatus.loading:
        return AppColors.grayscale10;
      case SecondaryIconButtonStatus.disabled:
        return AppColors.grayscale20;
    }
  }
}

enum SecondaryIconButtonStatus {
  idle,
  pressed,
  loading,
  disabled,
}


// Example of use:

// SecondaryIconButton(
//               status: SecondaryIconButtonStatus.loading,
//               icon: Icons.add,
//               onPressed: () {
//                 print('Button pressed');
//               },
//             ),
//             const SizedBox(height: 16),
//             SecondaryIconButton(
//               status: SecondaryIconButtonStatus.idle,
//               icon: Icons.add,
//               onPressed: () {
//                 print('Button pressed');
//               },
//             ),
//             const SizedBox(height: 16),
//             const SecondaryIconButton(
//               status: SecondaryIconButtonStatus.disabled,
//               icon: Icons.add,
//             ),
//             const SizedBox(height: 16),
//             SecondaryIconButton(
//               status: SecondaryIconButtonStatus.pressed,
//               icon: Icons.add,
//               onPressed: () {
//                 print('Button pressed');
//               },
//             ),