import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class CustomTag extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CustomTag({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: selected ? AppColors.secondary30 : AppColors.grayscale10,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child:
              Text(label, style: AppFonts.body2(color: AppColors.grayscale90)),
        ),
      ),
    );
  }
}
