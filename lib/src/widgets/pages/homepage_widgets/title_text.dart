import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppFonts.title4(color: AppColors.grayscale100),
      textAlign: TextAlign.center,
    );
  }
}
