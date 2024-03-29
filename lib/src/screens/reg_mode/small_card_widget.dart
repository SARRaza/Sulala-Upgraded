import 'package:flutter/material.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'reg_home_page.dart';

class SmallCardWidget extends StatefulWidget {
  final Image icon;
  final String quan;
  final AnimalData animalData;
  final VoidCallback onPressed;

  final bool isSelected;

  const SmallCardWidget({
    Key? key,
    required this.icon,
    required this.quan,
    required this.onPressed,
    required this.animalData,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<SmallCardWidget> createState() => _SmallCardWidgetState();
}

class _SmallCardWidgetState extends State<SmallCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        if (widget
            .isSelected) // Show the back card only when isSelected is true
          Positioned.fill(
            child: Material(
              type: MaterialType.card,
              color: const Color.fromRGBO(
                  225, 219, 190, 1), // Change the color for the back card
              borderRadius: BorderRadius.circular(
                  SizeConfig.widthMultiplier(context) * 14),
            ),
          ),
        Padding(
          padding:
          EdgeInsets.only(bottom: SizeConfig.heightMultiplier(context) * 6),
          child: Material(
            type: MaterialType.card,
            color: const Color.fromRGBO(249, 245, 236, 1),
            borderRadius: BorderRadius.circular(
                SizeConfig.widthMultiplier(context) *
                    14), // Change the color for the front card
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(
                  SizeConfig.widthMultiplier(context) * 14),
              child: Padding(
                padding:
                EdgeInsets.all(SizeConfig.widthMultiplier(context) * 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.icon,
                    SizedBox(height: SizeConfig.heightMultiplier(context) * 10),
                    Text(widget.animalData.animal,
                        style: AppFonts.body2(color: AppColors.grayscale100)),
                    SizedBox(height: SizeConfig.heightMultiplier(context) * 3),
                    Text(widget.quan,
                        style:
                        AppFonts.headline4(color: AppColors.grayscale100)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
