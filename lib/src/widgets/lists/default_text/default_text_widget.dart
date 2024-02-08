import 'package:flutter/material.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class DefaultTextWidget extends StatefulWidget {
  final String textHead;
  final Function(bool isChecked) onPressed;

  const DefaultTextWidget({
    Key? key,
    required this.textHead,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<DefaultTextWidget> createState() => _DefaultTextWidgetState();
}

class _DefaultTextWidgetState extends State<DefaultTextWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: AppColors.grayscale10,
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onPressed(_isChecked);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: SizeConfig.widthMultiplier(context) * 15,
              ),
              Expanded(
                child: Text(
                  widget.textHead,
                  style: AppFonts.body2(
                    color: AppColors.grayscale90,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              if (_isChecked)
                Image.asset(
                  "assets/icons/frame/24px/24_Check.png",
                ),
              SizedBox(
                width: SizeConfig.widthMultiplier(context) * 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}