import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class PrimaryDateField extends ConsumerStatefulWidget {
  final String hintText;
  final String? labelText;
  final String? errorMessage;
  final ValueChanged<DateTime>? onChanged;
  final ValueChanged<bool>? onErrorChanged;
  final TextEditingController? controller;

  const PrimaryDateField(
      {Key? key,
      required this.hintText,
      this.labelText,
      this.errorMessage,
      this.onChanged,
      this.onErrorChanged,
      this.controller})
      : super(key: key);

  @override
  ConsumerState<PrimaryDateField> createState() => _PrimaryDateFieldState();
}

class _PrimaryDateFieldState extends ConsumerState<PrimaryDateField> {
  DateTime? _selectedDate;
  late FocusNode _focusNode;
  bool isFocused = false;

  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _textEditingController = widget.controller ?? TextEditingController();
    _textEditingController.addListener(() {
      if (!_textEditingController.text.startsWith('D')) {
        setState(() {
          final dateSegments = _textEditingController.text
              .split('/')
              .map((segment) => int.parse(segment))
              .toList();
          _selectedDate =
              DateTime(dateSegments[2], dateSegments[1], dateSegments[0]);
        });
      }
    });
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

    //Clear the hintText when the field gains focus
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
      ref.read(dateOfBirthProvider.notifier).update((state) => pickedDate);
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

  Color _getBorderColor() {
    if (widget.errorMessage != null) {
      return AppColors.error100;
    } else if (isFocused || _selectedDate != null) {
      return AppColors.primary40; // Change to the desired primary40 color
    } else {
      return AppColors.grayscale20;
    }
  }

  Color _getBackgroundColor() {
    if (widget.errorMessage != null) {
      return AppColors.error10;
    } else if (isFocused) {
      return AppColors.primary20; // Change to the desired primary20 color
    } else {
      return AppColors.grayscale0;
    }
  }

  void _clearDate() {
    setState(() {
      _selectedDate = null;
      _textEditingController.text = widget.hintText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDateSelected = _textEditingController.text.isNotEmpty;

    final Color hintTextColor =
        isDateSelected ? AppColors.grayscale90 : AppColors.grayscale50;

    final Color borderColor = _getBorderColor();
    final Color backgroundColor = _getBackgroundColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Column(
            children: [
              Text(
                widget.labelText!,
                style: AppFonts.caption2(
                  color: AppColors.grayscale90,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
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
                      style: AppFonts.body2(
                        color: isDateSelected
                            ? AppColors.grayscale90
                            : hintTextColor,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: widget.hintText,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(
                      right: SizeConfig.widthMultiplier(context) * 10),
                  onPressed: () {
                    if (_selectedDate != null) {
                      _clearDate();
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
                          'assets/icons/frame/24px/20_Clear_form.png',
                          width: 24,
                          height: 24,
                        ),
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
//   child: PrimaryDateField(
//     hintText: 'Select a date',
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

