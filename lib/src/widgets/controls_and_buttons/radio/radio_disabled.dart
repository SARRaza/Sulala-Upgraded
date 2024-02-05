import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';

class RadioDisabled extends StatefulWidget {
  final bool isActive;

  const RadioDisabled({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  State<RadioDisabled> createState() => _RadioDisabledState();
}

class _RadioDisabledState extends State<RadioDisabled> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? AppColors.grayscale50 : AppColors.grayscale20,
        border: Border.all(
          width: 1,
          color: isActive ? AppColors.grayscale50 : AppColors.grayscale30,
        ),
      ),
      child: isActive
          ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.grayscale0,
                ),
              ),
            )
          : null,
    );
  }
}

// Example of use:

// RadioDisabled(isActive: false)
