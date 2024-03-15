import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onErrorChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const PasswordField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.errorMessage,
    this.onChanged,
    this.onErrorChanged,
    this.validator,
    this.controller
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _textEditingController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  void _onChanged(String value) {
    widget.onChanged!(value);
    if (widget.onErrorChanged != null) {
      widget.onErrorChanged!(false); // Clear the error state
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTyping = _textEditingController.text.isNotEmpty;

    final Color hintTextColor =
        isTyping ? AppColors.grayscale90 : AppColors.grayscale50;

    final Color borderColor = widget.errorMessage != null
        ? AppColors.error100
        : isFocused
            ? AppColors.primary30
            : AppColors.grayscale20;

    final Color backgroundColor =
        widget.errorMessage != null ? AppColors.error10 : AppColors.grayscale0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: AppFonts.caption2(
              color: AppColors.grayscale90,
            ),
          ),
        const SizedBox(height: 8.0),
        TextFormField(
          validator: widget.validator,
          controller: _textEditingController,
          onChanged: _onChanged,
          focusNode: _focusNode,
          obscureText:
              _obscureText, // Use obscureText property for password field
          onTap: () {
            _focusNode.requestFocus();
          },
          onEditingComplete: () {
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            fillColor: backgroundColor,
            filled: true,
            hintText: widget.hintText,
            hintStyle: AppFonts.body2(
              color: hintTextColor,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(24.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            suffixIcon: isTyping
                ? IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      color: AppColors.grayscale90,
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null,
          ),
          style: AppFonts.body2(
            color: AppColors.grayscale90,
          )
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

// bool passwordHasError = false;
// String? enteredPassword;

//  PasswordField(
//                 hintText: 'Confirm Password',
//                 errorMessage: passwordHasError
//                     ? 'Password should be at least 8 characters long and contain at least one number'
//                     : null,
//                 onChanged: (value) {
//                   setState(() {
//                     enteredPassword = value;
//                   });
//                 },
//                 onErrorChanged: (hasError) {
//                   setState(() {
//                     passwordHasError = hasError; // Update the error state
//                   });
//                 },
//               ),
