import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../controls_and_buttons/buttons/primary_button.dart';
import '../../controls_and_buttons/text_buttons/primary_textbutton.dart';

class DrowupWidget extends StatefulWidget {
  final Widget content;
  final String? heading;
  final double? heightFactor;
  final PrimaryTextButton? primaryTextButton;
  final PrimaryButton? primaryButton;

  const DrowupWidget(
      {Key? key,
      required this.content,
      this.heading,
      this.heightFactor,
      this.primaryTextButton,
      this.primaryButton})
      : super(key: key);

  @override
  State<DrowupWidget> createState() => _DrowupWidgetState();
}

class _DrowupWidgetState extends State<DrowupWidget> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: widget.heightFactor ?? 0.6, // Take 70% of the screen height
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.grayscale0,
          backgroundBlendMode: null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.heading != null)
                SizedBox(height: globals.heightMediaQuery * 21),
              widget.heading != null
                  ? widget.primaryTextButton != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.heading!,
                              style:
                                  AppFonts.title3(color: AppColors.grayscale90),
                            ),
                            widget.primaryTextButton!,
                          ],
                        )
                      : Text(
                          widget.heading!,
                          style: AppFonts.title3(color: AppColors.grayscale90),
                        )
                  : const SizedBox.shrink(),
              const SizedBox(height: 16),
              widget.content,
              SizedBox(
                  height: globals.heightMediaQuery * 52,
                  width: globals.widthMediaQuery * 343,
                  child: widget.primaryButton),
            ],
          ),
        ),
      ),
    );
  }
}

// Example of use:

// ElevatedButton(
//   onPressed: () {
//     _showFilterModalSheet(context);
//   },
//   child: const Text('Open Filter Modal Sheet'),
// );

// void _showFilterModalSheet(BuildContext context) {
//   showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     context: context,
//     isScrollControlled: true,
//     isDismissible: true,
//     builder: (BuildContext context) {
//       return Container(
//         color: Colors.transparent,
//         child: DrowupWidget(
//           // heading: 'Filter',
//           content: Column(
//             children: [
//               Text('Hello World'),
//               // Add Your Widgets Here
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
