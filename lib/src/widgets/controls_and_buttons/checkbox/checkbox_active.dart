import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';

class CheckBoxActive extends StatefulWidget {
  final bool checked;
  final Function(bool) onChanged;

  const CheckBoxActive({
    Key? key,
    required this.checked,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CheckBoxActive> createState() => _CheckBoxActiveState();
}

class _CheckBoxActiveState extends State<CheckBoxActive> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        _checked ? AppColors.primary20 : AppColors.grayscale0;
    final borderColor = _checked ? AppColors.primary20 : AppColors.grayscale30;
    final checkColor = _checked ? AppColors.grayscale0 : null;

    return GestureDetector(
      onTap: _toggleChecked,
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: _checked
            ? Icon(
                Icons.check,
                color: checkColor,
                size: 16.0,
              )
            : null,
      ),
    );
  }

  void _toggleChecked() {
    setState(() {
      _checked = !_checked;
      widget.onChanged(_checked);
    });
  }
}

// Example of use:

// CheckBoxActive(
//             checked: true, // or false depending on the initial state
//             onChanged: (bool checked) {
//               // Handle the checked status change here
//             },
//           ),
