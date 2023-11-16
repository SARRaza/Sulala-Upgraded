import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class ButtonSearchBar extends StatefulWidget {
  final ValueChanged<String> onChange;
  final String hintText;
  final IconData icon;
  final VoidCallback? onIconPressed;
  final TextEditingController? controller;

  const ButtonSearchBar({
    Key? key,
    required this.onChange,
    required this.hintText,
    required this.icon,
    this.onIconPressed,
    this.controller,
  }) : super(key: key);

  @override
  State<ButtonSearchBar> createState() => _ButtonSearchBarState();
}

class _ButtonSearchBarState extends State<ButtonSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
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
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    widget.onChange(value);
    setState(() {});
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTyping = _textEditingController.text.isNotEmpty;

    final Color hintTextColor =
        isTyping ? AppColors.grayscale90 : AppColors.grayscale50;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: isFocused ? AppColors.primary30 : AppColors.grayscale20,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              onChanged: _onChanged,
              focusNode: _focusNode,
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grayscale90,
                ),
              ),
              style: AppFonts.body2(
                color: AppColors.grayscale90,
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: widget.onIconPressed,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Image(
                image: AssetImage(
                  'assets/icons/frame/24px/filter.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Example of use:

// SizedBox(
//               height: 48,
//               width: 343,
//               child: ButtonSearchBar(
//                 onChange: (value) {
//                   print('Search query: $value');
//                   print('#################');
//                 },
//                 hintText: 'Search',
//                 icon: Icons.filter_alt_outlined,
//                 onIconPressed: () {
//                   print('Button pressed');
//                 },
//               ),
//             ),