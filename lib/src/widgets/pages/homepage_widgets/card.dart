import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../controls_and_buttons/buttons/primary_button.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

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
        width: globals.widthMediaQuery * 165,
        height: globals.heightMediaQuery * 203,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: globals.widthMediaQuery * 22,
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
              child: SizedBox(
                width: globals.widthMediaQuery * 133,
                height: globals.heightMediaQuery * 40,
                child: PrimaryButton(
                  status: PrimaryButtonStatus.idle,
                  text: buttonText,
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
