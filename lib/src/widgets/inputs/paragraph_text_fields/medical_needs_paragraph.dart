import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class MedicalNeedsParagraphTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onErrorChanged;
  final TextEditingController controller;
  final int maxLines; // Add maxLines property

  const MedicalNeedsParagraphTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.labelText,
    this.errorMessage,
    this.onChanged,
    this.onErrorChanged,
    this.maxLines = 1, // Default to a single line
  }) : super(key: key);

  @override
  State<MedicalNeedsParagraphTextField> createState() =>
      _MedicalNeedsParagraphTextField();
}

class _MedicalNeedsParagraphTextField
    extends State<MedicalNeedsParagraphTextField> {
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
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
      final hasNumbers = value.contains(RegExp(r'[0-9]'));
      if (widget.onErrorChanged != null) {
        widget.onErrorChanged!(hasNumbers); // Report the error state
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTyping = widget.controller.text.isNotEmpty;

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
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
          child: Stack(
            children: [
              TextField(
                controller: widget.controller,
                onChanged: _onChanged,
                focusNode: _focusNode,
                maxLines:
                    widget.maxLines, // Set the maximum number of lines allowed
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: AppFonts.body2(
                    color: hintTextColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  border: InputBorder.none,
                ),
                style: AppFonts.body2(
                  color: AppColors.grayscale90,
                ),
              ),
              if (isTyping)
                Positioned(
                  top: 4.0,
                  right: 4.0,
                  child: IconButton(
                    onPressed: _clearText,
                    icon: Image.asset(
                      'assets/icons/frame/24px/20_Clear_form.png',
                    ),
                  ),
                ),
            ],
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