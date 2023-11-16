import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';

class RadioActive extends StatefulWidget {
  final bool isActive;
  final Function(bool) onChanged;

  const RadioActive({
    Key? key,
    required this.isActive,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RadioActive> createState() => _RadioActiveState();
}

class _RadioActiveState extends State<RadioActive> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
        widget.onChanged(isActive);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive ? AppColors.primary20 : AppColors.grayscale0,
          border: Border.all(
            width: 1,
            color: isActive ? AppColors.primary20 : AppColors.grayscale30,
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
      ),
    );
  }
}



// Example of use:

// RadioActive(
//               isActive: true,
//               onChanged: (isActive) {
//                 if (isActive) {
//                 } else {}
//               },
//             ),