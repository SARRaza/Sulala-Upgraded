import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class LabelDateField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String? errorMessage;
  final ValueChanged<DateTime>? onChanged;
  final ValueChanged<bool>? onErrorChanged;

  const LabelDateField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.errorMessage,
    this.onChanged,
    this.onErrorChanged,
  }) : super(key: key);

  @override
  State<LabelDateField> createState() => _LabelDateFieldState();
}

class _LabelDateFieldState extends State<LabelDateField> {
  DateTime? _selectedDate;
  late FocusNode _focusNode;
  bool isFocused = false;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    // Initialize the controller with the hintText
    _textEditingController.text = widget.hintText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });

    // Clear the hintText when the field gains focus
    if (isFocused) {
      if (_textEditingController.text == widget.hintText) {
        _textEditingController.text = '';
      }
    } else {
      // Restore the hintText if no date is selected and field loses focus
      if (_selectedDate == null) {
        _textEditingController.text = widget.hintText;
      }
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color of the date picker
            primaryColor: AppColors.primary30,
            colorScheme: const ColorScheme.light(primary: AppColors.primary20),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // Here you can customize more colors if needed
            // For example, you can change the header color, selected day color, etc.
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _textEditingController.text = _formatDate(pickedDate);
      });

      if (widget.onChanged != null) {
        widget.onChanged!(pickedDate);
      }

      if (widget.onErrorChanged != null) {
        final hasError = pickedDate.isAfter(DateTime.now());
        widget.onErrorChanged!(hasError); // Report the error state
      }
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }

  Color getBorderColor() {
    if (widget.errorMessage != null) {
      return AppColors.error100;
    } else if (isFocused || _selectedDate != null) {
      return AppColors.primary40; // Change to the desired primary40 color
    } else {
      return AppColors.grayscale20;
    }
  }

  Color getBackgroundColor() {
    if (widget.errorMessage != null) {
      return AppColors.error10;
    } else if (isFocused) {
      return AppColors.primary20; // Change to the desired primary20 color
    } else {
      return AppColors.grayscale0;
    }
  }

  void clearDate() {
    setState(() {
      _selectedDate = null;
      _textEditingController.text = widget.hintText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDateSelected = _selectedDate != null;

    final Color hintTextColor =
        isDateSelected ? AppColors.grayscale90 : AppColors.grayscale50;

    final Color borderColor = getBorderColor();
    final Color backgroundColor = getBackgroundColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: AppFonts.caption2(
            color: AppColors.grayscale90,
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: borderColor,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: TextFormField(
                      controller: _textEditingController,
                      enabled: false,
                      style: AppFonts.body2(
                        color: isDateSelected
                            ? AppColors.grayscale90
                            : hintTextColor,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: '',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_selectedDate != null) {
                      clearDate();
                    } else {
                      _selectDate(context);
                    }
                  },
                  icon: _selectedDate == null
                      ? const Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.primary30,
                        )
                      : Image.asset(
                          'assets/icons/frame/24px/20_Clear_form.png'),
                ),
              ],
            ),
          ),
        ),
        if (widget.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.errorMessage!,
              style: AppFonts.caption2(
                color: AppColors.error100,
              ),
            ),
          ),
      ],
    );
  }
}

// Example of use:

// SizedBox(
//   width: 300,
//   child: LabelDateField(
//     hintText: 'Select a date',
//     labelText: 'Date of Birth',
//     errorMessage: _hasError
//         ? 'Selected date should not be in the future'
//         : null,
//     onChanged: (selectedDate) {
//       final hasError = selectedDate.isAfter(DateTime.now());
//       setState(() {
//         _hasError = hasError;
//         _selectedDate = hasError ? null : selectedDate;
//       });
//     },
//     onErrorChanged: (hasError) {
//       setState(() {
//         _hasError = hasError;
//       });
//     },
//   ),
// ),

// Text(
//   'Entered Text: ${_selectedDate != null ? _formatDate(_selectedDate!) : ""}',
//   style: const TextStyle(fontSize: 16),
// ),

//           String _formatDate(DateTime date) {
//   return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
// }
