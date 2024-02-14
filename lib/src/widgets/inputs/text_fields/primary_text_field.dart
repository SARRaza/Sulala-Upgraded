import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class PrimaryTextField extends ConsumerStatefulWidget {
  final String hintText;
  final String? labelText;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onErrorChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const PrimaryTextField(
      {Key? key,
      required this.hintText,
      this.errorMessage,
      this.onChanged,
      this.onErrorChanged,
      required this.controller,
      this.labelText,
      this.keyboardType,
      this.validator,
      })
      : super(key: key);

  @override
  ConsumerState<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends ConsumerState<PrimaryTextField> {
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  void _clearText() {
    widget.controller.clear();
    if (widget.onErrorChanged != null) {
      widget.onErrorChanged!(false); // Clear the error state
    }
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
    if (widget.onErrorChanged != null) {
      widget.onErrorChanged!(false); // Clear the error state
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTyping = widget.controller.text.isNotEmpty;

    const Color hintTextColor = AppColors.grayscale50;

    final Color borderColor = widget.errorMessage != null
        ? AppColors.error100
        : isFocused
            ? AppColors.primary30
            : AppColors.grayscale20;

    final Color backgroundColor =
        widget.errorMessage != null ? AppColors.error10 : Colors.transparent;

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
        TextFormField(
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          onChanged: _onChanged,
          focusNode: _focusNode,
          onTap: () {
            _focusNode.requestFocus();
          },
          onEditingComplete: () {
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            fillColor: backgroundColor,
            hintText: widget.hintText,
            hintStyle: AppFonts.body2(
              color: hintTextColor,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide(color: borderColor, width: 1.0)),
            suffixIcon: isTyping
                ? IconButton(
                    onPressed: _clearText,
                    icon: Image.asset(
                      'assets/icons/frame/24px/20_Clear_form.png',
                    ),
                  )
                : null,
          ),
          style: AppFonts.body2(
            color: AppColors.grayscale90,
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

// String _enteredText = '';
// bool _hasError = false;

// PrimaryTextField(
//   hintText: 'Enter your username',
//   errorMessage: _hasError ? 'Username should not contain numbers' : null,
//   onChanged: (value) {
//     setState(() {
//       _enteredText = value;
//       _hasError = value.contains(RegExp(r'[0-9]')); // Set the error state
//     });
//   },
//   onErrorChanged: (hasError) {
//     setState(() {
//       _hasError = hasError; // Update the error state
//     });
//   },
// );
