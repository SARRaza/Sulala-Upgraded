import 'package:flutter/material.dart';

import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../controls_and_buttons/text_buttons/primary_text_button.dart';

class TableTextButton extends StatefulWidget {
  final String textHead;
  final String textButton;
  final VoidCallback onPressed;

  const TableTextButton({
    Key? key,
    required this.textHead,
    required this.textButton,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<TableTextButton> createState() => _TableTextButtonState();
}

class _TableTextButtonState extends State<TableTextButton> {
  String _truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              _truncateTextWithEllipsis(widget.textHead, 25),
              style: AppFonts.body2(
                color: AppColors.grayscale70,
              ),
            ),
            const Spacer(),
            PrimaryTextButton(
              status: TextStatus.idle,
              position: TextButtonPosition.right,
              onPressed: widget.onPressed,
              text: widget.textButton,
            ),
          ],
        ),
      ],
    );
  }
}