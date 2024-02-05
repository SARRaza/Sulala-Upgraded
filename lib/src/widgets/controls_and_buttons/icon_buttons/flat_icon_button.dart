import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import '../../../theme/colors/colors.dart';

class FlatIconButton extends StatelessWidget {
  final FlatIconButtonStatus status;
  final IconData icon;
  final VoidCallback? onPressed;

  const FlatIconButton({
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
      case FlatIconButtonStatus.idle:
      case FlatIconButtonStatus.pressed:
        return IconButton(
          onPressed: onPressed,
          icon: _buildIcon(),
          splashRadius: 24,
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
          alignment: Alignment.center,
        );
      case FlatIconButtonStatus.loading:
        return const SizedBox(
          height: 39,
          child: NutsActivityIndicator(
            radius: 12,
            activeColor: AppColors.grayscale90,
            tickCount: 8,
            inactiveColor: Colors.transparent,
          ),
        );
      case FlatIconButtonStatus.disabled:
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

  Color _getBackgroundColor(FlatIconButtonStatus status) {
    switch (status) {
      case FlatIconButtonStatus.idle:
        return AppColors.grayscale0;
      case FlatIconButtonStatus.pressed:
        return AppColors.grayscale10;
      case FlatIconButtonStatus.loading:
        return AppColors.grayscale0;
      case FlatIconButtonStatus.disabled:
        return AppColors.grayscale0;
    }
  }
}

enum FlatIconButtonStatus {
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
