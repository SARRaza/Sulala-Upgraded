import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';

class ToggleActive extends StatefulWidget {
  final bool value;
  final Function(bool)? onChanged;

  const ToggleActive({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ToggleActive> createState() => _ToggleActiveState();
}

class _ToggleActiveState extends State<ToggleActive> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        _value ? AppColors.primary20 : AppColors.grayscale20;
    final circleColor = _value ? AppColors.grayscale0 : AppColors.grayscale0;

    return GestureDetector(
      onTap: _toggleValue,
      child: Container(
        width: 50.0,
        height: 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: backgroundColor,
        ),
        child: Stack(
          children: [
            Positioned(
              left: _value ? 20.0 : 0.0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                  border: Border.all(
                    color: backgroundColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleValue() {
    setState(() {
      _value = !_value;
      widget.onChanged!(_value);
    });
  }
}