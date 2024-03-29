import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../controls_and_buttons/buttons/primary_button.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class CardWidget extends StatelessWidget {
  final Color color;
  final String iconPath;
  final String title;

  final String buttonText;
  final VoidCallback onPressed;

  const CardWidget({
    super.key,
    required this.color,
    required this.iconPath,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      color: color,
      child: Container(
        width: 165,
        height: 208,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: SizeConfig.widthMultiplier(context) * 22,
              child: Image.asset(
                iconPath,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppFonts.headline3(
                      color: AppColors.grayscale100,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: PrimaryButton(
                status: PrimaryButtonStatus.idle,
                text: buttonText,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
