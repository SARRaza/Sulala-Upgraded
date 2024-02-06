import 'package:flutter/material.dart';

import '../data/globals.dart';
import '../theme/colors/colors.dart';
import '../theme/fonts/fonts.dart';

class OptionRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;

  const OptionRow({
    Key? key,
    required this.label,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(label, style: AppFonts.body2(color: AppColors.grayscale70)),
          const Spacer(),
          Text(value, style: AppFonts.body2(color: AppColors.grayscale90)),
          SizedBox(width: SizeConfig.widthMultiplier(context) * 8),
          Icon(Icons.arrow_forward_ios_rounded,
              color: AppColors.primary40,
              size: SizeConfig.widthMultiplier(context) * 12.75),
        ],
      ),
    );
  }
}
