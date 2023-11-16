import 'package:flutter/material.dart';
import 'package:sulala_app/src/theme/colors/colors.dart';
import 'package:sulala_app/src/theme/fonts/fonts.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onErrorChanged; // Add this line

  const PasswordField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.errorMessage,
    this.onChanged,
    this.onErrorChanged,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode;
  bool isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
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
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
          child: TextField(
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
              hintText: widget.hintText,
              hintStyle: AppFonts.body2(
                color: hintTextColor,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: InputBorder.none,
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
